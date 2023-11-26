package com.heima.kafka.sample;

import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.TimeWindows;
import org.apache.kafka.streams.kstream.ValueMapper;

import java.time.Duration;
import java.util.Arrays;
import java.util.Properties;

/**
 * 流式处理
 */
public class KafkaStreamQuickStart {
    public static void main(String[] args) {
        // 创建KafkaStream对象
        Properties properties = new Properties();
        properties.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "139.198.181.54:9092");
        properties.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass());
        properties.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass());
        properties.put(StreamsConfig.APPLICATION_ID_CONFIG, "streams-quickstar");

        // stream构建器
        StreamsBuilder streamsBuilder = new StreamsBuilder();

        // 流式计算
        streamProcessor(streamsBuilder);

        // 创建KafkaStreams对象
        KafkaStreams kafkaStreams = new KafkaStreams(streamsBuilder.build(), properties);
        // 开启流式计算
        kafkaStreams.start();

    }

    /**
     * 流式计算
     * 消息的内容：hello Kafka
     *
     * @param streamsBuilder
     */
    private static void streamProcessor(StreamsBuilder streamsBuilder) {
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
                .to("itcast-topic-out")
        ;
    }
}
