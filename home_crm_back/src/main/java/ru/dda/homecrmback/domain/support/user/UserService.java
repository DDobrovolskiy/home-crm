package ru.dda.homecrmback.domain.support.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.support.user.context.UserContextHolder;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserDomainService userDomainService;

    @Transactional
    public Result<String, IFailAggregate> registration(User.Registration command) {
        return userDomainService.registration(command)
                .map(UserAggregate::getToken);
    }

    @Transactional(readOnly = true)
    public Result<UserAggregate.DTO.UserDTO, IFailAggregate> getUserOrganization() {
        return User.FindById.of(UserContextHolder.getCurrentUser().getUserId())
                .execute(userDomainService::getUserAggregateById)
                .map(UserAggregate::userOrganizationDTO);
    }

    @Transactional(readOnly = true)
    public Result<String, IFailAggregate> login(SimpleLoginDTO dto) {
        return userDomainService.getUserAggregateByPhone(dto.phone())
                .then(userAggregate -> userAggregate.login(dto));
    }

    @Transactional
    public Result<Boolean, IFailAggregate> logout(String token) {
        return userDomainService.getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }

    @Transactional(readOnly = true)
    public Result<Boolean, IFailAggregate> check(String token) {
        return userDomainService.getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }
}
