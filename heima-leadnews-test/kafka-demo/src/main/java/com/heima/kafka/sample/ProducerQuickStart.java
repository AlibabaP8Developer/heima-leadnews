package com.heima.kafka.sample;

import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;

import java.util.Properties;
import java.util.concurrent.ExecutionException;

public class ProducerQuickStart {
    public static void main(String[] args) {
        try {
            // 1.Kafka连接配置
            Properties properties = new Properties();
            properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "139.198.181.54:9092");
            // key and value序列化
            properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer");
            properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer");
            // ack配置，消息确认机制
            properties.put(ProducerConfig.ACKS_CONFIG, "all");
            // 重试次数
            properties.put(ProducerConfig.RETRIES_CONFIG, 10);
            // 数据压缩  默认消息发送不会被压缩
            // snappy 占用较少cpu，却能提供较好的性能和相当可观的压缩比，如果看重性能和网络带宽，建议采用
            // lz4 占用较少cpu，压缩和解压缩速度较快，压缩比也很客观
            // gzip 占用较多的cpu，但会提供更高的压缩比，网络带宽有限，可以使用这种算法
            properties.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "snappy");
            // 2.创建Kafka生产者对象
            KafkaProducer<String, String> producer = new KafkaProducer<>(properties);

            // 3.发送消息
            /*
                参数1：topic
                参数2：分区
                参数3：消息key
                参数4：消息value
             */
            for (int i = 0; i < 5; i++) {
                ProducerRecord<String, String> kvProducerRecord = new ProducerRecord<>("itcast-topic-input", 0, "key-001", "hello kafka");
                producer.send(kvProducerRecord);
            }


            //ProducerRecord<String, String> kvProducerRecord = new ProducerRecord<>("topic-first", 0, "key-001", "hello kafka");
            // 同步发送消息
            //RecordMetadata recordMetadata = producer.send(kvProducerRecord).get();
            //System.out.println(recordMetadata.offset());

            // 异步
            //producer.send(kvProducerRecord, (recordMetadata, e) -> {
            //    if (e != null) {
            //        System.out.println("记录异常信息到日志表中");
            //    }
            //    System.out.println(recordMetadata.offset());
            //});

            // 4.关闭消息通道，否则消息发送不成功
            producer.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}