package com.heima.schedule.service.impl;

import com.alibaba.fastjson.JSON;
import com.heima.common.redis.CacheService;
import com.heima.model.schedule.dto.Task;
import com.heima.model.schedule.pojo.Taskinfo;
import com.heima.model.schedule.pojo.TaskinfoLogs;
import com.heima.schedule.mapper.TaskinfoLogsMapper;
import com.heima.schedule.mapper.TaskinfoMapper;
import com.heima.schedule.service.TaskService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;

import static com.heima.common.constants.ScheduleConstants.*;

@Slf4j
@Service
@Transactional
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskinfoMapper taskinfoMapper;
    @Autowired
    private TaskinfoLogsMapper taskinfoLogsMapper;
    @Autowired
    private CacheService cacheService;

    /**
     * 添加延迟任务
     *
     * @param task
     * @return
     */
    @Override
    public long addTask(Task task) {
        // 添加任务到数据库中
        boolean success = addTaskToDb(task);

        // 添加任务到rRedis
        if (success) {
            addTaskToCache(task);
        }
        // 如果任务的执行时间小于等于当前时间，存入list
        return task.getTaskId();
    }

    private void addTaskToCache(Task task) {
        String key = task.getTaskType() + "-" + task.getPriority();

        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 5);

        long nextScheduleTime = calendar.getTimeInMillis();

        if (task.getExecuteTime() <= System.currentTimeMillis()) {
            cacheService.lLeftPush(TOPIC + key, JSON.toJSONString(task));
        } else if (task.getExecuteTime() <= nextScheduleTime) {
            // 如果任务的执行时间大于当前&&小于等于预设时间（未来5分钟）存入zset中
            cacheService.zAdd(FUTURE + key, JSON.toJSONString(task), task.getExecuteTime());
        }
    }

    /**
     * 添加任务到数据库
     *
     * @param task
     * @return
     */
    private boolean addTaskToDb(Task task) {
        boolean flag = false;
        try {
            // 保存任务表
            Taskinfo taskinfo = new Taskinfo();
            BeanUtils.copyProperties(task, taskinfo);
            taskinfo.setExecuteTime(new Date(task.getExecuteTime()));
            this.taskinfoMapper.insert(taskinfo);

            // 设置taskId
            task.setTaskId(taskinfo.getTaskId());

            // 保存任务日志表
            TaskinfoLogs taskinfoLogs = new TaskinfoLogs();
            BeanUtils.copyProperties(taskinfo, taskinfoLogs);
            taskinfoLogs.setVersion(1);
            taskinfoLogs.setStatus(SCHEDULED);
            this.taskinfoLogsMapper.insert(taskinfoLogs);

            flag = true;
        } catch (BeansException e) {
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 取消任务
     *
     * @param taskId 任务Id
     * @return
     */
    @Override
    public boolean cancalTask(long taskId) {
        boolean flag = false;
        // 删除任务，更新任务日志
        Task task = updateDb(taskId, CANCELLED);
        // 删除redis
        if (task != null) {
            removeTaskFromCache(task);
            flag = true;
        }
        return flag;
    }

    /**
     * 按照类型和优先级拉取任务
     *
     * @return
     */
    @Override
    public Task poll(int type, int priority) {
        Task task = null;
        try {
            String key = type + "-" + priority;
            // 从redis拉取数据
            String taskJson = cacheService.lRightPop(TOPIC + key);
            if (StringUtils.isNotBlank(taskJson)) {
                task = JSON.parseObject(taskJson, Task.class);
                // 修改数据库信息
                updateDb(task.getTaskId(), EXECUTED);
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("poll task exception: {}", e.getMessage());
        }
        return task;
    }

    /**
     * 删除redis中的数据
     *
     * @param task
     */
    private void removeTaskFromCache(Task task) {
        String key = task.getTaskType() + "-" + task.getPriority();
        if (task.getExecuteTime() <= System.currentTimeMillis()) {
            cacheService.lRemove(TOPIC + key, 0, JSON.toJSONString(task));
        } else {
            cacheService.zRemove(FUTURE + key, JSON.toJSONString(task));
        }
    }

    /**
     * 删除任务，更新任务日志
     *
     * @param taskId
     * @param status
     * @return
     */
    private Task updateDb(long taskId, int status) {
        Task task = null;
        try {
            // 删除任务
            taskinfoMapper.deleteById(taskId);

            //更新任务日志
            TaskinfoLogs taskinfoLogs = taskinfoLogsMapper.selectById(taskId);
            taskinfoLogs.setStatus(status);
            taskinfoLogsMapper.updateById(taskinfoLogs);

            task = new Task();
            BeanUtils.copyProperties(taskinfoLogs, task);
            task.setExecuteTime(taskinfoLogs.getExecuteTime().getTime());
        } catch (BeansException e) {
            log.error("task cancel exception taskId:{}", taskId);
            throw new RuntimeException(e);
        }
        return task;
    }
}
