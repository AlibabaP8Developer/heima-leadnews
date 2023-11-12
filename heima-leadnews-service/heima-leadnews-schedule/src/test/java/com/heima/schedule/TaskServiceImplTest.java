package com.heima.schedule;

import com.heima.common.redis.CacheService;
import com.heima.model.schedule.dto.Task;
import com.heima.schedule.service.TaskService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;
import java.util.Set;

import static com.heima.common.constants.ScheduleConstants.FUTURE;
import static com.heima.common.constants.ScheduleConstants.TOPIC;

@Slf4j
@SpringBootTest(classes = ScheduleApplication.class)
@RunWith(SpringRunner.class)
public class TaskServiceImplTest {

    @Autowired
    private TaskService taskService;
    @Autowired
    private CacheService cacheService;

    @Test
    public void addTask() {
        Task task = new Task();
        task.setTaskType(100);
        task.setPriority(50);
        task.setParameters("task test!!".getBytes());
        task.setExecuteTime(new Date().getTime());
        long id = taskService.addTask(task);
        System.out.println(id);
    }

    @Test
    public void cancelTask() {
        taskService.cancalTask(1723156589910806529L);
    }

    @Test
    public void testPoll() {
        Task task = taskService.poll(100, 50);
        System.out.println(task);
    }

    @Scheduled(cron = "0 */1 * * * ?")
    public void refresh() {
        log.info("未来数据定时刷新——定时任务");
        // 获取所有未来数据的集合key
        Set<String> futureKeys = cacheService.scan(FUTURE + "*");
        for (String futureKey : futureKeys) {
            // 获取当前数据的key   topic
            String topicKey = TOPIC + futureKey.split(FUTURE)[1];
            // 按照key和分值查询符合条件的数据
            Set<String> tasks = cacheService.zRangeByScore(futureKey, 0, System.currentTimeMillis());
            // 同步数据
            if (!tasks.isEmpty()) {
                cacheService.refreshWithPipeline(futureKey, topicKey, tasks);
                log.info("成功的将" + futureKey + "刷新到了" + topicKey);
            }
        }
    }

}
