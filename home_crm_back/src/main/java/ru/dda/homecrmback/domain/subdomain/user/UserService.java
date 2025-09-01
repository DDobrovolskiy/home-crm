package ru.dda.homecrmback.domain.subdomain.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserDTO;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserEmployeesDTO;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserOrganizationsDTO;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.auth.dto.response.AuthSuccessDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserDomainService userDomainService;

    @Transactional
    public Result<AuthSuccessDTO, IFailAggregate> registration(User.Registration command) {
        return userDomainService.registration(command)
                .map(UserAggregate::getAuthSuccessDTO);
    }

    @Transactional(readOnly = true)
    public Result<UserDTO, IFailAggregate> getUser() {
        return User.FindById.of(UserContextHolder.getCurrentUser().getUserId())
                .execute(userDomainService::getUserAggregateById)
                .map(UserAggregate::getUserDTO);
    }

    @Transactional(readOnly = true)
    public Result<UserOrganizationsDTO, IFailAggregate> getUserOrganization() {
        return User.FindById.of(UserContextHolder.getCurrentUser().getUserId())
                .execute(userDomainService::getUserAggregateById)
                .map(UserAggregate::getUserOrganizationsDTO);
    }

    @Transactional(readOnly = true)
    public Result<UserEmployeesDTO, IFailAggregate> getUserEmployee() {
        return User.FindById.of(UserContextHolder.getCurrentUser().getUserId())
                .execute(userDomainService::getUserAggregateById)
                .map(UserAggregate::getUserEmployeesDTO);
    }

    @Transactional(readOnly = true)
    public Result<AuthSuccessDTO, IFailAggregate> login(SimpleLoginDTO dto) {
        return userDomainService.getUserAggregateByPhone(dto.phone())
                .then(userAggregate -> userAggregate.login(dto));
    }

    @Transactional
    public Result<Boolean, IFailAggregate> logout(String token) {
        return userDomainService.getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }

    @Transactional(readOnly = true)
    public Result<AuthSuccessDTO, IFailAggregate> loginWithToken(String token) {
        return userDomainService.getUserAggregateByToken(token)
                .map(UserAggregate::getAuthSuccessDTO);
    }
}
