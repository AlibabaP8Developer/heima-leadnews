package com.heima.kafka.stream;

import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.TimeWindows;
import org.apache.kafka.streams.kstream.ValueMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Duration;
import java.util.Arrays;

@Slf4j
@Configuration
public class KafkaStreamHelloListener {

    @Bean
    public KStream<String, String> KStream(StreamsBuilder streamsBuilder) {
        // 创建stream对象，同时指定从那个topic中接收消息
        KStream<String, String> stream = streamsBuilder.stream("itcast-topic-input");
        /**
         * 处理消息的value值
         */
        stream.flatMapValues(new ValueMapper<String, Iterable<?>>() {
                    /**
                     * 处理消息的value
                     * @param value 消息的value
                     * @return
                     */
                    @Override
                    public Iterable<?> apply(String value) {
                        String[] valAry = value.split(" ");
                        return Arrays.asList(valAry);
                    }
                }).groupBy((key, value) -> { // 按照value进行聚合处理
                    return value;
                }).windowedBy(TimeWindows.of(Duration.ofSeconds(10))) // 时间窗口
                .count() // 统计单词的个数
                .toStream() // 转换为KStream
                .map((key, value) -> {
                    System.out.println("key:" + key+"，value:"+value);
                    return new KeyValue<>(key.key().toString(), value.toString());
                })
                // 发送消息
                .to("itcast-topic-out");
        return stream;
    }
}
