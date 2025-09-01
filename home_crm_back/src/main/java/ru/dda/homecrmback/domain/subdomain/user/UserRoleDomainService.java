package ru.dda.homecrmback.domain.subdomain.user;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.user.aggregate.UserRoleAggregate;
import ru.dda.homecrmback.domain.subdomain.user.repository.UserRoleRepository;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserRoleDomainService {
    private final UserRoleRepository userRoleRepository;

    @Transactional(readOnly = true)
    public Result<UserRoleAggregate, IFailAggregate> getUserAggregateById(long userId, long organizationId) {
        return userRoleRepository.findByUserIdAndOrganizationId(userId, organizationId)
                .map(Result::<UserRoleAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ORGANIZATION_NOT_FOUND.fail())));
    }
}
