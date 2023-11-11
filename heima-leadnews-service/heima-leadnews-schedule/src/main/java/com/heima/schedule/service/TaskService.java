package com.heima.schedule.service;

import com.heima.model.schedule.dto.Task;

public interface TaskService {

    /**
     * 添加延迟任务
     * @param task
     * @return
     */
    long addTask(Task task);

    /**
     * 取消任务
     * @param taskId
     * @return
     */
    boolean cancalTask(long taskId);

    /**
     * 按照类型和优先级拉取任务
     * @return
     */
    Task poll(int type, int priority);
}
