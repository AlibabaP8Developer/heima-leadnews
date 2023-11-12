package com.heima.schedule;

import com.alibaba.fastjson.JSON;
import com.heima.common.redis.CacheService;
import com.heima.model.schedule.dto.Task;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;
import java.util.Set;

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

    @Test
    public void testKey() {
        Set<String> keys = cacheService.keys("future_");
        System.out.println(keys);
        Set<String> future = cacheService.scan("future_");
        System.out.println(future);
    }

    @Test
    public void testPiple() {
        long start = System.currentTimeMillis();
        for (int i = 0; i < 10000; i++) {
            Task task = new Task();
            task.setTaskType(1001);
            task.setPriority(1);
            task.setExecuteTime(new Date().getTime());
            cacheService.lLeftPush("1001_1", JSON.toJSONString(task));
        }
        System.out.println("耗时：" + (System.currentTimeMillis() - start));
    }

    @Test
    public void testPiple2() {
        long start = System.currentTimeMillis();
        cacheService.getstringRedisTemplate().executePipelined(new RedisCallback<Object>() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                for (int i = 0; i < 10000; i++) {
                    Task task = new Task();
                    task.setTaskType(1001);
                    task.setPriority(1);
                    task.setExecuteTime(new Date().getTime());
                    redisConnection.lPush("100_1".getBytes(), JSON.toJSONString(task).getBytes());
                }
                return null;
            }
        });
        System.out.println("使用管道技术执行10000次自增操作共耗时：" + (System.currentTimeMillis() - start) + "毫秒");
    }
}
