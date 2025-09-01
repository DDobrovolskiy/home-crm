package ru.dda.homecrmback.domain.subdomain.employee;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.repository.EmployeeRepository;
import ru.dda.homecrmback.domain.subdomain.organization.OrganizationService;
import ru.dda.homecrmback.domain.subdomain.user.UserDomainService;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.role.RoleService;
import ru.dda.homecrmback.domain.support.scope.ScopeType;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmployeeService {
    private final UserDomainService userDomainService;
    private final OrganizationService organizationService;
    private final RoleService roleService;
    private final EmployeeRepository employeeRepository;

    @Transactional
    public Result<EmployeeAggregate, IFailAggregate> registrationEmployee(Employee.Registration command) {
        return roleService.checkScope(ScopeType.ORGANIZATION_UPDATE, () ->
                Result.merge(
                                command.user().execute(userDomainService::registrationOrGet),
                                command.organization().execute(organizationService::findById),
                                command.role().execute(roleService::findByIdAndOrganizationId),
                                (EmployeeAggregate::create))
                        .isTrue(employeeAggregate -> employeeRepository.findByUserIdAndOrganizationId(
                                        employeeAggregate.getUser().getId(), employeeAggregate.getOrganization().getId()).isEmpty(),
                                onFail -> ResultAggregate.Fails.Default.of(FailEvent.EMPLOYEE_IS_EXIST.fail()))
                        .then(employeeAggregate -> {
                            try {
                                return Result.success(employeeRepository.save(employeeAggregate));
                            } catch (Exception e) {
                                log.error(e.getMessage(), e);
                                return Result.fail(ResultAggregate.Fails.Default.of(
                                        FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения отрудника")));
                            }
                        }));
    }
}
