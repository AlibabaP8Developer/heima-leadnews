package com.heima.search.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.common.enums.AppHttpCodeEnum;
import com.heima.model.search.UserSearchDto;
import com.heima.search.service.ArticleSearchService;
import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.text.Text;
import org.elasticsearch.index.query.*;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public class ArticleSearchServiceImpl implements ArticleSearchService {

    @Autowired
    private RestHighLevelClient restHighLevelClient;

    @Override
    public ResponseResult search(UserSearchDto dto) {
        List<Map> list = Lists.newArrayList();

        // 1.检查参数
        if (dto == null || StringUtils.isBlank(dto.getSearchWords())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }
        try {
            // 2.设置查询条件
            SearchRequest searchRequest = new SearchRequest("app_info_article");
            SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
            // 关键字分词之后的查询
            QueryStringQueryBuilder queryStringQueryBuilder = QueryBuilders.queryStringQuery(dto.getSearchWords()).field("title").field("content")
                    .defaultOperator(Operator.OR);

            // 布尔查询
            BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery();
            boolQueryBuilder.must(queryStringQueryBuilder);

            // 查询小于mindate的数据
            RangeQueryBuilder rangeQueryBuilder = QueryBuilders.rangeQuery("publishTime").lt(dto.getMinBehotTime().getTime());
            boolQueryBuilder.filter(rangeQueryBuilder);

            // 分页查询
            searchSourceBuilder.from(0);
            searchSourceBuilder.size(dto.getPageSize());

            // 按照发布时间倒序查询
            searchSourceBuilder.sort("publishTime", SortOrder.DESC);

            // 设置高亮 title
            HighlightBuilder highlightBuilder = new HighlightBuilder();
            highlightBuilder.field("title");
            highlightBuilder.preTags("<font style='color: red; font-size: inherit;'>");
            highlightBuilder.postTags("</font>");
            searchSourceBuilder.highlighter(highlightBuilder);

            searchSourceBuilder.query(boolQueryBuilder);
            searchRequest.source(searchSourceBuilder);
            SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);
            // 3.结果封装返回
            SearchHit[] hits = searchResponse.getHits().getHits();
            for (SearchHit hit : hits) {
                String sourceAsString = hit.getSourceAsString();
                Map map = JSON.parseObject(sourceAsString, Map.class);
                // 处理高亮
                Map<String, HighlightField> highlightFields = hit.getHighlightFields();
                if (highlightFields != null && !highlightFields.isEmpty()) {
                    Text[] titles = hit.getHighlightFields().get("title").getFragments();
                    String title = StringUtils.join(titles);
                    // 高亮标题
                    map.put("h_title", title);
                } else {
                    // 原始标题
                    map.put("h_title", map.get("title"));
                }
                list.add(map);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return ResponseResult.okResult(list);
    }
}
