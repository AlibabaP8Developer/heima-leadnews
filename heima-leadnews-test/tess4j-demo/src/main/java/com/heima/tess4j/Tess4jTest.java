package com.heima.tess4j;

import net.sourceforge.tess4j.Tesseract;
import net.sourceforge.tess4j.TesseractException;

import java.io.File;

public class Tess4jTest {
    public static void main(String[] args) {
        Tesseract tesseract = new Tesseract();
        // 设置字体库路径
        tesseract.setDatapath("/Users/lizhenghang/workspace/java/itheima/heima-leadnews/heima-leadnews-test/tess4j-demo/src/main/resources");
        // 设置语言
        tesseract.setLanguage("chi_sim");

        File file = new File("/Users/lizhenghang/workspace/java/itheima/heima-leadnews/heima-leadnews-test/tess4j-demo/src/main/resources/3.jpg");
        try {
            // 识别图片
            String result = tesseract.doOCR(file);
            System.out.println(result);
        } catch (TesseractException e) {
            e.printStackTrace();
        }
    }
}
