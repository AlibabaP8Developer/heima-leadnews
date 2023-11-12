package com.heima.wemedia.service.impl;

import com.heima.wemedia.service.WmNewsTaskService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;

@Slf4j
@Service
public class WmNewsTaskServiceImpl implements WmNewsTaskService {

    /**
     * 添加任务到延迟队列中
     * @param id 文章的ID
     * @param publishTime 发布的时间，可以作为任务的执行时间
     */
    @Override
    public void addNewToTask(Integer id, Date publishTime) {

    }
}
