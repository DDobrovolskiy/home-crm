package ru.dda.homecrmback.domain.support.auth.config.filter;


import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.connector.RequestFacade;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.subdomain.user.UserDomainService;
import ru.dda.homecrmback.domain.subdomain.user.UserRoleDomainService;
import ru.dda.homecrmback.domain.subdomain.user.context.IUserContext;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.api.Api;
import ru.dda.homecrmback.domain.support.auth.controller.IAuthController;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;

import java.io.IOException;
import java.util.Objects;

@Slf4j
@Component
@AllArgsConstructor
public class AuthHeaderFilter implements Filter {
    private final UserDomainService userDomainService;
    private final UserRoleDomainService userRoleService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            RequestFacade requestFacade = (RequestFacade) request;
            if (!(requestFacade).getServletPath().contains(IAuthController.PATH) && !Objects.equals(requestFacade.getMethod(), "OPTIONS")) {
                Result.<String, IFailAggregate>success(getHeaderValue(request, Api.AUTHORIZATION_HEADER))
                        .isTrue(StringUtils::hasText,
                                onFail -> {
                                    log.warn("Токена нет в заголовке");
                                    return ResultAggregate.Fails.Default.of(FailEvent.NOT_FOUND.fail("Токен в заголовке"));
                                })
                        .then(userDomainService::getUserAggregateByToken) //TODO кэш
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
