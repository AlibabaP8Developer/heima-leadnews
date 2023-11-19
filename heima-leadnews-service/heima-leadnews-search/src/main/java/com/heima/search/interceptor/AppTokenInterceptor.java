package com.heima.search.interceptor;

import com.heima.model.user.pojo.ApUser;
import com.heima.utils.thread.AppThreadLocalUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AppTokenInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String userId = request.getHeader("userId");
        if (StringUtils.isNotBlank(userId)) {
            // 存入到当前线程中
            ApUser apUser = new ApUser();
            apUser.setId(Integer.parseInt(userId));
            AppThreadLocalUtil.setUser(apUser);
        }
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        AppThreadLocalUtil.clear();
    }

}
