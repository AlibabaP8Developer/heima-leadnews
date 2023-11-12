package com.heima.wemedia.service;

import java.util.Date;

public interface WmNewsTaskService {

    /**
     * 添加任务到延迟队列中
     * @param id 文章的ID
     * @param publishTime 发布的时间，可以作为任务的执行时间
     */
    void addNewToTask(Integer id, Date publishTime);
}
