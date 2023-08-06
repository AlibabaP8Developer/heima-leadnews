package com.heima.article.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.heima.model.article.dto.ArticleDto;
import com.heima.model.article.dto.ArticleHomeDto;
import com.heima.model.article.pojo.ApArticle;
import com.heima.model.common.dtos.ResponseResult;
import org.springframework.web.bind.annotation.RequestBody;

public interface ApArticleService extends IService<ApArticle> {

    /**
     * 根据参数加载文章列表
     * @param loadType 1为加载更多  2为加载最新
     * @param dto
     * @return
     */
    ResponseResult load(ArticleHomeDto dto, Short loadType);

    /**
     * 保存App端相关文章
     * @param articleDto
     * @return
     */
    ResponseResult saveArticle(@RequestBody ArticleDto articleDto);
}
