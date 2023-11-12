package com.heima.kafka.controller;

import com.alibaba.fastjson.JSON;
import com.heima.kafka.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KafkaHelloController {

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    @GetMapping("hello")
    public String hello() {
        kafkaTemplate.send("itheima-topic", "大明太祖爷朱元璋");
        return "ok";
    }

    @GetMapping("obj")
    public String helloObject() {
        User user = new User();
        user.setAge(10);
        user.setUsername("大明太祖爷 高皇帝朱元璋  朱重八  父：朱五四  爷：朱初一  太爷：朱四九  老爷爷：朱百六");
        kafkaTemplate.send("user-topic", JSON.toJSONString(user));
        return "ok";
    }

}
