package com.heima.article.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.heima.article.mapper.ApArticleConfigMapper;
import com.heima.article.mapper.ApArticleContentMapper;
import com.heima.article.mapper.ApArticleMapper;
import com.heima.article.service.ApArticleService;
import com.heima.model.article.dto.ArticleDto;
import com.heima.model.article.dto.ArticleHomeDto;
import com.heima.model.article.pojo.ApArticle;
import com.heima.model.article.pojo.ApArticleConfig;
import com.heima.model.article.pojo.ApArticleContent;
import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.common.enums.AppHttpCodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

import static com.heima.common.constants.ArticleConstants.*;

@Service
@Transactional
@Slf4j
public class ApArticleServiceImpl extends ServiceImpl<ApArticleMapper, ApArticle> implements ApArticleService {

    // 单页最大加载的数字
    private final static short MAX_PAGE_SIZE = 50;

    @Autowired
    private ApArticleMapper apArticleMapper;

    @Autowired
    private ApArticleConfigMapper apArticleConfigMapper;
    private ApArticleContentMapper apArticleContentMapper;

    @Override
    public ResponseResult load(ArticleHomeDto dto, Short type) {
        // 校验参数
        // 分页条数、type参数、频道、时间
        Integer size = dto.getSize();
        String tag = dto.getTag();
        Date maxBehotTime = dto.getMaxBehotTime();
        Date minBehotTime = dto.getMinBehotTime();

        if (size == null || size == 0) {
            size = 10;
        }

        size = Math.min(size, MAX_PAGE_SIZE);

        if (!type.equals(LOADTYPE_LOAD_MORE) && !type.equals(LOADTYPE_LOAD_NEW)) {
            type = LOADTYPE_LOAD_MORE;
        }

        if (StringUtils.isBlank(tag)) {
            dto.setTag(DEFAULT_TAG);
        }

        if (maxBehotTime == null) {
            dto.setMaxBehotTime(new Date());
        }

        if (minBehotTime == null) {
            dto.setMinBehotTime(new Date());
        }

        // 查询
        List<ApArticle> articleList = apArticleMapper.loadArticleList(dto, type);
        // 结果返回
        return ResponseResult.okResult(articleList);
    }

    @Override
    public ResponseResult saveArticle(ArticleDto articleDto) {
        // 1.检查参数
        if (articleDto == null) {
            ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        ApArticle article = new ApArticle();
        if (articleDto != null) {
            BeanUtils.copyProperties(articleDto, article);
        }
        // 2.判断是否存在ID
        if (articleDto != null && articleDto.getId() == null) {
            // 2.1不存在ID 保存文章、文章配置、文章内容
            save(article);
            ApArticleConfig apArticleConfig = new ApArticleConfig();
            apArticleConfig.setArticleId(article.getId());
            apArticleConfigMapper.insert(apArticleConfig);
            // 保存文章内容
            ApArticleContent apArticleContent = new ApArticleContent();
            apArticleContent.setArticleId(apArticleContent.getId());
            apArticleContent.setContent(apArticleContent.getContent());
            apArticleContentMapper.insert(apArticleContent);
        } else {
            // 2.2存在ID 修改 文章内容
            updateById(article);
            // 修改文章内容
            LambdaQueryWrapper<ApArticleContent> queryWrapper = new LambdaQueryWrapper<>();
            if (articleDto != null) {
                queryWrapper.eq(ApArticleContent::getArticleId, articleDto.getId());
            }
            ApArticleContent apArticleContent = apArticleContentMapper.selectOne(queryWrapper);
            if (articleDto != null) {
                apArticleContent.setContent(articleDto.getContent());
            }
            apArticleContentMapper.updateById(apArticleContent);
        }
        // 3.结果返回，文章ID
        return ResponseResult.okResult(article.getId());
    }

}
