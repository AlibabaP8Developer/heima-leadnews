package com.heima.article.controller.v1;

import com.heima.apis.article.IArticleClient;
import com.heima.article.service.ApArticleService;
import com.heima.model.article.dto.ArticleDto;
import com.heima.model.common.dtos.ResponseResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class ArticleController implements IArticleClient {

    @Resource
    ApArticleService apArticleService;

    @PostMapping("/api/v1/article/save")
    @Override
    public ResponseResult saveArticle(@RequestBody ArticleDto articleDto) {
        return apArticleService.saveArticle(articleDto);
    }
}
