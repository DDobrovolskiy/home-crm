package ru.dda.homecrmback.domain.support.auth.config.filter;


import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.apache.catalina.connector.RequestFacade;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.support.api.Api;
import ru.dda.homecrmback.domain.support.auth.controller.IAuthController;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.user.UserRoleService;
import ru.dda.homecrmback.domain.support.user.UserService;
import ru.dda.homecrmback.domain.support.user.context.IUserContext;
import ru.dda.homecrmback.domain.support.user.context.UserContextHolder;

import java.io.IOException;

@Component
@AllArgsConstructor
public class AuthHeaderFilter implements Filter {
    private final UserService userService;
    private final UserRoleService userRoleService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            if (!((RequestFacade) request).getServletPath().contains(IAuthController.PATH)) {
                Result.<String, IFailAggregate>success(getHeaderValue(request, Api.AUTHORIZATION_HEADER))
                        .isTrue(StringUtils::hasText,
                                onFail -> ResultAggregate.Fails.Default.of(FailEvent.NOT_FOUND.fail("Токен в заголовке")))
                        .then(userService::getUserAggregateByToken) //TODO кэш
                        .map(IUserContext::getUserInfo)
                        .then(userInfo -> {
                            String organizationHeader = getHeaderValue(request, Api.ORGANIZATION_HEADER);
                            if (StringUtils.hasText(organizationHeader)) {
                                try {
                                    long organizationId = Long.parseLong(organizationHeader);
                                    return userRoleService.getUserAggregateById(userInfo.getUserId(), organizationId)
                                            .map(IUserContext::getUserInfo);
                                } catch (Exception e) {
                                    return Result.fail(ResultAggregate.Fails.Default.of(FailEvent.WRONG_HEADER.fail()));
                                }
                            }
                            return Result.success(userInfo);
                        })
                        .consumer(userInfo -> {
                                    UserContextHolder.setCurrentUser(userInfo);
                                    chain.doFilter(request, response);
                                },
                                fail -> ((HttpServletResponse) response).sendError(HttpServletResponse.SC_UNAUTHORIZED,
                                        "Не авторизован"));
            } else {
                chain.doFilter(request, response);
            }
        } finally {
            UserContextHolder.clear();
        }
    }

    private String getHeaderValue(ServletRequest request, String headerName) {
        return ((HttpServletRequest) request).getHeader(headerName);
    }
}
