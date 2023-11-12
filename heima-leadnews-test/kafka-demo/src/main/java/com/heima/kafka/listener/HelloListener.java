package com.heima.kafka.listener;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class HelloListener {
    @KafkaListener(topics = "itheima-topic")
    public void onMessage(String msg) {
        if (!StringUtils.isEmpty(msg)) {
            System.out.println("kafka测试：" + msg);
        }
    }

    @KafkaListener(topics = "user-topic")
    public void onMessageObj(String msg) {
        if (!StringUtils.isEmpty(msg)) {
            System.out.println("kafka测试对象：" + msg);
        }
    }
}
