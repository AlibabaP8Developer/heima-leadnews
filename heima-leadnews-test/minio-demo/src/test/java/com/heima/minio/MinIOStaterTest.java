package com.heima.minio;

import com.heima.file.service.FileStorageService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.FileInputStream;

@SpringBootTest(classes = MinIOApplication.class)
@RunWith(SpringRunner.class)
public class MinIOStaterTest {

    @Autowired
    private FileStorageService fileStorageService;

    @Test
    public void test() throws Exception {
        FileInputStream fileInputStream = new FileInputStream("/Users/lizhenghang/Desktop/资料/具体问题.docx");
        String path = fileStorageService.uploadHtmlFile("", "具体问题.docx", fileInputStream);
        System.out.println(path);
    }

}
