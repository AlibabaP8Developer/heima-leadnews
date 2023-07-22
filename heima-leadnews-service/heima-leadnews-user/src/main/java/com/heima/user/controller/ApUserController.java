package com.heima.user.controller;

import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.user.dto.LoginDTO;
import com.heima.user.service.ApUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "App端用户相关接口", value = "App端用户相关接口")
@RestController
@RequestMapping("、api/v1")
public class ApUserController {

    @Autowired
    private ApUserService apUserService;

    /**
     * ppp登录
     * @param loginDTO
     * @return
     */
    @ApiOperation(value = "用户登录")
    @PostMapping("/login/login_auth")
    public ResponseResult login(@RequestBody LoginDTO loginDTO) {
        return apUserService.login(loginDTO);
    }
}
