package com.heima.app.gateway.filter;

import com.heima.app.gateway.util.AppJwtUtil;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class AuthorizeFilter implements Ordered, GlobalFilter {

    /**
     * @param exchange
     * @param chain
     * @return
     */
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        // 1 获取request和response
        ServerHttpRequest request = exchange.getRequest();
        ServerHttpResponse response = exchange.getResponse();

        // 2 判断是否登录
        String path = request.getURI().getPath();
        if (path.contains("/login")) {
            // 放行
            return chain.filter(exchange);
        }
        // 3 获取token
        String token = request.getHeaders().getFirst("token");

        // 4 判断token是否存在
        if (StringUtils.isBlank(token)) {
            response.setStatusCode(HttpStatus.UNAUTHORIZED);
            return response.setComplete();
        }

        try {
            // 5 判断token是否有效
            Claims claimsBody = AppJwtUtil.getClaimsBody(token);
            // 是否过期
            int result = AppJwtUtil.verifyToken(claimsBody);
            if (result == 1 || result == 2) {
                response.setStatusCode(HttpStatus.UNAUTHORIZED);
                return response.setComplete();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatusCode(HttpStatus.UNAUTHORIZED);
            return response.setComplete();
        }

        // 6 放行
        return chain.filter(exchange);
    }

    /**
     * 优先级设置 值越小越先执行
     *
     * @return
     */
    @Override
    public int getOrder() {
        return 0;
    }
}
