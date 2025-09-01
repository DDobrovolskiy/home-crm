package ru.dda.homecrmback.domain.support.role;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.support.role.repository.RoleRepository;
import ru.dda.homecrmback.domain.support.scope.ScopeType;

import java.util.function.Supplier;

@Slf4j
@Service
@RequiredArgsConstructor
public class RoleService {
    private final RoleRepository roleRepository;

    public Result<RoleAggregate, IFailAggregate> create(RoleAggregate.Command.Create command) {
        return command.execute()
                .then(roleAggregate -> {
                    try {
                        return Result.success(roleRepository.save(roleAggregate));
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения роли")));
                    }
                });
    }

    @Transactional
    public Result<RoleAggregate, IFailAggregate> findById(Role.FindById command) {
        return roleRepository.findById(command.roleId())
                .map(Result::<RoleAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ROLE_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<RoleAggregate, IFailAggregate> findByIdAndOrganizationId(Role.FindByIdAndOrganizationId command) {
        return roleRepository.findByIdAndOrganizationId(command.roleId(), command.organizationId())
                .map(Result::<RoleAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ROLE_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<RoleAggregate, IFailAggregate> findByNameAndOrganizationId(Role.FindByNameAndOrganizationId command) {
        return roleRepository.findByNameAndOrganizationId(command.roleName(), command.organizationId())
                .map(Result::<RoleAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ROLE_NOT_FOUND.fail())));
    }


    @Transactional
    public <S> Result<S, IFailAggregate> checkScope(ScopeType scopeType, Supplier<Result<S, IFailAggregate>> supplier) {
        return Role.FindById.of(UserContextHolder.getCurrentUser().getRoleId())
                .execute(this)
                .isTrue(roleAggregate -> roleAggregate.roleHasScope(scopeType),
                        onFail -> ResultAggregate.Fails.Default.of(FailEvent.PERMISSION_DENIED.fail(scopeType.getDescription())))
                .then(r -> supplier.get());
    }
}
