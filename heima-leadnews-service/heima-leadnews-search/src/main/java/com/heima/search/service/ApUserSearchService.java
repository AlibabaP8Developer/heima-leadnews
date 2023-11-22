package com.heima.search.service;

import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.search.HistorySearchDto;

public interface ApUserSearchService {
    /**
     * 保存用户搜索记录
     * @param keyword
     * @param userId
     */
    void insert(String keyword, Integer userId);

    /**
     * 查询搜索历史
     * @return
     */
    ResponseResult findUserSearch();

    /**
     * 删除历史记录
     * @param dto
     * @return
     */
    ResponseResult deleteUserSearch(HistorySearchDto dto);
}
