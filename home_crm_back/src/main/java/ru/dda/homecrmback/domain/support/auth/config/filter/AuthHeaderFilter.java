package ru.dda.homecrmback.domain.support.auth.config.filter;


import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.apache.catalina.connector.RequestFacade;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.support.auth.controller.IAuthController;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.user.UserService;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.support.user.context.UserContextHolder;

import java.io.IOException;

@Component
@AllArgsConstructor
public class AuthHeaderFilter implements Filter {
    private final UserService userService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            if (!((RequestFacade) request).getServletPath().contains(IAuthController.PATH)) {
                Result.<String, IFailAggregate>success(((HttpServletRequest) request).getHeader("Authorization"))
                        .isTrue(StringUtils::hasText,
                                onFail -> ResultAggregate.Fails.Default.of(FailEvent.NOT_FOUND.arg("Токен в заголовке")))
                        .then(userService::getUserAggregateByToken)
                        .map(UserAggregate::getUserInfo)
                        .consumer(UserContextHolder::setCurrentUser,
                                fail -> ((HttpServletResponse) response).sendError(HttpServletResponse.SC_UNAUTHORIZED,
                                        "Не авторизован"));
            }
            chain.doFilter(request, response);
        } finally {
            UserContextHolder.clear();
        }
    }
}
