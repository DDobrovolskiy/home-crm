package ru.dda.homecrmback.domain.subdomain.role;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.organization.OrganizationService;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.subdomain.role.dto.RoleAggregateDTO;
import ru.dda.homecrmback.domain.subdomain.role.repository.RoleRepository;
import ru.dda.homecrmback.domain.subdomain.scope.ScopeService;
import ru.dda.homecrmback.domain.subdomain.scope.enums.ScopeType;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;

import java.util.Set;
import java.util.function.Supplier;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class RoleService {
    private final RoleRepository roleRepository;
    private final OrganizationService organizationService;
    private final ScopeService scopeService;

    @Transactional
    public Result<RoleAggregate, IFailAggregate> create(Role.Create command) {
        return checkScope(ScopeType.ORGANIZATION_UPDATE, () ->
                Result.merge(
                                command.organization().execute(organizationService::findById),
                                command.scopes().execute(scopeService::find),
                                ((organizationAggregate, scopes) -> RoleAggregate
                                        .create(command.name(), command.description(), organizationAggregate, scopes)))
                        .then(roleAggregate -> {
                            try {
                                return Result.success(roleRepository.save(roleAggregate));
                            } catch (Exception e) {
                                log.error(e.getMessage(), e);
                                return Result.fail(ResultAggregate.Fails.Default.of(
                                        FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения роли")));
                            }
                        }));
    }

    @Transactional
    public Result<RoleAggregate, IFailAggregate> update(Role.Update command) {
        return checkScope(ScopeType.ORGANIZATION_UPDATE, () ->
                Result.merge(
                        command.role().execute(this::find),
                        command.scopes().execute(scopeService::find),
                        ((roleAggregate, scopes) ->
                                roleAggregate.update(command.name(), command.description(), scopes))));
    }

    @Transactional
    public Result<Integer, IFailAggregate> delete(Role.Delete command) {
        return checkScope(ScopeType.ORGANIZATION_UPDATE, () ->
                command.role().execute(this::find)
                        .isTrue(role -> role.getEmployees().isEmpty(),
                                onFail -> ResultAggregate.Fails.Default.of(FailEvent.ROLE_HAS_EMPLOYEE.fail(onFail.getName())))
                        .then(roleAggregate -> {
                            try {
                                roleRepository.delete(roleAggregate);
                                return Result.success(1);
                            } catch (Exception e) {
                                log.error(e.getMessage(), e);
                                return Result.fail(ResultAggregate.Fails.Default.of(
                                        FailEvent.ERROR_ON_SAVE.fail("Ошибка удаления роли: %s".formatted(command.role().roleId()))));
                            }
                        }));
    }

    @Transactional(readOnly = true)
    public Result<RoleAggregate, IFailAggregate> getCurrent(Role.Current command) {
        return roleRepository.findById(command.roleId())
                .map(Result::<RoleAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ROLE_NOT_FOUND.fail())));
    }

    @Transactional(readOnly = true)
    public Result<RoleAggregate, IFailAggregate> find(Role.Find command) {
        return roleRepository.findByIdAndOrganizationId(command.roleId(), command.organizationId())
                .map(Result::<RoleAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ROLE_NOT_FOUND.fail())));
    }


    @Transactional(readOnly = true)
    public <S> Result<S, IFailAggregate> checkScope(ScopeType scopeType, Supplier<Result<S, IFailAggregate>> supplier) {
        return Role.Current.of()
                .execute(this::getCurrent)
                .isTrue(roleAggregate -> roleAggregate.roleHasScope(scopeType),
                        onFail -> ResultAggregate.Fails.Default.of(FailEvent.PERMISSION_DENIED.fail(scopeType.getDescription())))
                .then(r -> supplier.get());
    }

    @Transactional(readOnly = true)
    public Result<Set<RoleAggregateDTO>, IFailAggregate> roles() {
        try {
            Set<RoleAggregateDTO> collect = roleRepository.findAllByOrganization_Id(UserContextHolder.getCurrentUser().getOrganizationId()).stream()
                    .map(RoleAggregate::getRoleAggregateDTO)
                    .collect(Collectors.toSet());
            return Result.success(collect);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ERROR_ON_SAVE.fail(e.getMessage())));
        }
    }
}
