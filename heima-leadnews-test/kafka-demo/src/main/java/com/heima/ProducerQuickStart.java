package com.heima;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;

import java.util.Properties;

public class ProducerQuickStart {
    public static void main(String[] args) {
        // 1.Kafka连接配置
        Properties properties = new Properties();
        properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "139.198.181.54:9092");
        // key and value序列化
        properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer");
        properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer");
        // 2.创建Kafka生产者对象
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

        // 3.发送消息
        /*
            参数1：topic
            参数2：消息key
            参数3：消息value
         */
        ProducerRecord<String, String> kvProducerRecord = new ProducerRecord<>("topic-first", "key-001", "hello kafka");
        producer.send(kvProducerRecord);
        // 4.关闭消息通道，否则消息发送不成功
        producer.close();
    }
}