package com.heima.minio;

import io.minio.MinioClient;
import io.minio.PutObjectArgs;

import java.io.FileInputStream;

public class MinIOTest {

    public static void main(String[] args) throws Exception {
        FileInputStream fis = new FileInputStream("/Users/lizhenghang/nginx/developer/conf/nginx.conf");

        // 1 获取minio连接信息，
        MinioClient minioClient = MinioClient.builder().credentials("minioadmin", "minioadmin")
                .endpoint("http://139.198.181.54:9000").build();

        PutObjectArgs putObjectArgs = PutObjectArgs.builder()
                .object("nginx.conf") // 文件名称
                .contentType("text/html") // 文件类型
                .bucket("testbucket") // 桶名称
                .stream(fis, fis.available(), -1) // -1所有文件
                .build();
        minioClient.putObject(putObjectArgs);
        // 访问路径
        System.out.println("http://139.198.181.54:9000/testbucket/list.html");
    }
}
