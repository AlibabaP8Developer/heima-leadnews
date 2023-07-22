package com.heima.article.controller.v1;

import com.heima.article.service.ApArticleService;
import com.heima.model.article.dto.ArticleHomeDto;
import com.heima.model.common.dtos.ResponseResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import static com.heima.common.constants.ArticleConstants.LOADTYPE_LOAD_MORE;

@Api(tags = "文章首页相关接口", value = "文章首页相关接口")
@RestController
@RequestMapping("/api/v1/article")
public class ArticleHomeController {

    @Autowired
    private ApArticleService apArticleService;

    @ApiOperation("加载首页")
    @PostMapping("load")
    public ResponseResult load(@RequestBody ArticleHomeDto articleHomeDto) {
        return apArticleService.load(articleHomeDto, LOADTYPE_LOAD_MORE);
    }

    @ApiOperation("加载更多")
    @GetMapping("loadmore")
    public ResponseResult loadmore(@RequestBody ArticleHomeDto articleHomeDto) {
        return ResponseResult.okResult("");
    }

    @ApiOperation("加载最新")
    @GetMapping("loadnew")
    public ResponseResult loadnew(@RequestBody ArticleHomeDto articleHomeDto) {
        return ResponseResult.okResult("");
    }
}
