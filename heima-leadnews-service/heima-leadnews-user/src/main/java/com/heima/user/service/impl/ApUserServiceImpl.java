package com.heima.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.common.enums.AppHttpCodeEnum;
import com.heima.model.user.dto.LoginDTO;
import com.heima.model.user.pojo.ApUser;
import com.heima.user.mapper.ApUserMapper;
import com.heima.user.service.ApUserService;
import com.heima.utils.common.AppJwtUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ApUserServiceImpl extends ServiceImpl<ApUserMapper, ApUser> implements ApUserService {

    @Override
    public ResponseResult login(LoginDTO loginDTO) {
        // 正常登录
        String phone = loginDTO.getPhone();
        String password = loginDTO.getPassword();
        if (StringUtils.isNotBlank(phone) && StringUtils.isNotBlank(password)) {
            // 根据手机号查询用户信息
            LambdaQueryWrapper<ApUser> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(ApUser::getPhone, loginDTO.getPhone());
            ApUser apUser = this.getOne(queryWrapper);
            if (apUser == null) {
                return ResponseResult.errorResult(AppHttpCodeEnum.DATA_EXIST, "用户不存在");
            }
            // 比对密码
            String salt = apUser.getSalt();
            String passwordMd5 = DigestUtils.md5DigestAsHex((password + salt).getBytes(StandardCharsets.UTF_8));
            if (!passwordMd5.equals(apUser.getPassword())) {
                return ResponseResult.errorResult(AppHttpCodeEnum.LOGIN_PASSWORD_ERROR, "手机号或密码错误");
            }
            // 返回JWT
            String token = AppJwtUtil.getToken(apUser.getId().longValue());
            Map<String, Object> map = new HashMap<>();
            map.put("user", apUser);
            map.put("token", token);
            apUser.setSalt(null);
            apUser.setPassword(null);
            return ResponseResult.okResult(map);
        } else {
            // 游客登录
            Map<String, Object> map = new HashMap<>();
            map.put("token", AppJwtUtil.getToken(0L));
            // 游客登录
            return ResponseResult.okResult(map);
        }


    }
}
