package com.heima.model.user.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "用户登录", description = "用户登录对象")
public class LoginDTO {
    @ApiModelProperty(value = "用户手机号", required = true)
    private String phone;
    @ApiModelProperty(value = "密码", required = true)
    private String password;
}
