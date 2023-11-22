package com.heima.search.controller.v1;

import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.search.HistorySearchDto;
import com.heima.model.search.UserSearchDto;
import com.heima.search.service.ApUserSearchService;
import com.heima.search.service.ArticleSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/history")
public class ApUserSearchController {

    @Autowired
    ApUserSearchService apUserSearchService;

    @PostMapping("load")
    public ResponseResult findUserSearch() {
        return apUserSearchService.findUserSearch();
    }

    @PostMapping("del")
    public ResponseResult deleteUserSearch(@RequestBody HistorySearchDto dto) {
        return apUserSearchService.deleteUserSearch(dto);
    }

}
