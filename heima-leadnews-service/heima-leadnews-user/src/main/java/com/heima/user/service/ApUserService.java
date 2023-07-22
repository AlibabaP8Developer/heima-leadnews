package com.heima.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.user.dto.LoginDTO;
import com.heima.model.user.pojo.ApUser;

public interface ApUserService extends IService<ApUser> {
    /**
     * App登录
     * @param loginDTO
     * @return
     */
    ResponseResult login(LoginDTO loginDTO);
}
