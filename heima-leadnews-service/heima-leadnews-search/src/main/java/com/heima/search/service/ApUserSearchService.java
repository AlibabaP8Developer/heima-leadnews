package com.heima.search.service;

public interface ApUserSearchService {
    /**
     * 保存用户搜索记录
     * @param keyword
     * @param userId
     */
    void insert(String keyword, Integer userId);
}
