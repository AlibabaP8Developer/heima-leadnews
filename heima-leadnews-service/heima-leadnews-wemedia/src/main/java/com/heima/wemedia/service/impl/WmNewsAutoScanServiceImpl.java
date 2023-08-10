package com.heima.wemedia.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.heima.common.aliyun.GreenTextScan;
import com.heima.model.wemedia.pojos.WmNews;
import com.heima.wemedia.mapper.WmNewsMapper;
import com.heima.wemedia.service.WmNewsAutoScanService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Slf4j
@Transactional(readOnly = true)
public class WmNewsAutoScanServiceImpl implements WmNewsAutoScanService {
    @Autowired
    private WmNewsMapper wmNewsMapper;

    @Autowired
    private GreenTextScan greenTextScan;

    @Override
    @Transactional(readOnly = false)
    public void autoScanWmNews(Integer id) {
        // 1.查询自媒体文章
        WmNews wmNews = wmNewsMapper.selectById(id);
        if (wmNews == null) throw new RuntimeException("WmNewsAutoScanServiceImpl：文章不存在");

        Short status = wmNews.getStatus();
        short code = WmNews.Status.SUBMIT.getCode();
        if (status.equals(code)) {
            // 从内容中提取纯文本内容和图片
            Map<String, Object> textAndImages = handleTextAndImages(wmNews);
            // 2.审核文本内容  阿里云接口
            String content = textAndImages.get("content").toString();
            boolean isTextScan = handleTextScan(content, wmNews);
            if (!isTextScan) return;
            // 3.审核图片 阿里云接口

            // 4. 审核成功 保存App端的相关的文章数据
        }
    }

    /**
     * 审核文本内容  阿里云接口
     * @param content
     * @param wmNews
     */
    private boolean handleTextScan(String content, WmNews wmNews) {
        try {
            Map map = greenTextScan.greeTextScan(content);
            if (map != null) {
                String suggestion = map.get("suggestion").toString();
                // 审核失败
                if (suggestion.equals("block")) {

                }
                // 审核成功
                if (suggestion.equals("review")) {

                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    /**
     * 1.从自媒体文本的内容中提取文本和图片
     * 2.提取文章的封面图片
     *
     */
    private Map<String, Object> handleTextAndImages(WmNews wmNews) {
        StringBuilder sb = new StringBuilder();
        List<String> images = Lists.newArrayList();
        // 1.从自媒体文章的内容中提取文本和图片
        if (StringUtils.isNoneBlank(wmNews.getContent())) {
            List<Map> maps = JSONArray.parseArray(wmNews.getContent(), Map.class);
            maps.forEach(map -> {
                if (map.get("type").equals("text")) {
                    sb.append(map.get("value"));
                }
                if (map.get("type").equals("image")) {
                    images.add(map.get("value").toString());
                }
            });
        }

        // 2.提取文章的封面图片
        if (StringUtils.isNotBlank(wmNews.getImages())) {
            String[] split = wmNews.getImages().split(",");
            images.addAll(Arrays.asList(split));
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("content", sb.toString());
        resultMap.put("images", images);
        return resultMap;
    }
}
