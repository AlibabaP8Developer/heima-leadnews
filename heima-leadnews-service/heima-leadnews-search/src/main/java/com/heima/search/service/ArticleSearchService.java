package com.heima.search.service;

import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.search.UserSearchDto;

public interface ArticleSearchService {
    /**
     * ES文章分页检索
     * @param userSearchDto
     * @return
     */
    ResponseResult search(UserSearchDto userSearchDto);
}
