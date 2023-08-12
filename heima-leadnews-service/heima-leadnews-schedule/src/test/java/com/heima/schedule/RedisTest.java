package com.heima.schedule;

import com.heima.common.redis.CacheService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest(classes = ScheduleApplication.class)
@RunWith(SpringRunner.class)
public class RedisTest {

    @Autowired
    private CacheService cacheService;

    @Test
    public void testList() {
        // 在list左边添加元素
        cacheService.lLeftPush("list001", "hello");

        String list001 = cacheService.lRightPop("list_001");
        System.out.println(list001);
    }

    @Test
    public void testZset() {
        // 添加数据到zset中 分值
        cacheService.zAdd("zset:add:001", "hello-001", 1000);
        cacheService.zAdd("zset:add:002", "hello-002", 2000);
        cacheService.zAdd("zset:add:003", "hello-003", 3000);
        // 按照分值获取数据
    }
}
