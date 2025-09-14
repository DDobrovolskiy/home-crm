package ru.dda.homecrmback.domain.subdomain.education;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.education.repository.TestRepository;
import ru.dda.homecrmback.domain.subdomain.organization.OrganizationService;
import ru.dda.homecrmback.domain.subdomain.role.RoleService;
import ru.dda.homecrmback.domain.subdomain.scope.enums.ScopeType;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;

@Slf4j
@Service
@RequiredArgsConstructor
public class EducationService {

    private final OrganizationService organizationService;
    private final RoleService roleService;
    private final TestRepository testRepository;

    @Transactional(readOnly = true)
    public Result<TestAggregate, IFailAggregate> find(Education.Test.Find command) {
        return testRepository.findByIdAndOrganizationId(command.testId(), command.organization().organizationId())
                .map(Result::<TestAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.TEST_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<TestAggregate, IFailAggregate> create(Education.Test.Create command) {
        return roleService.checkScope(ScopeType.ORGANIZATION_UPDATE, () ->
                command.organization().execute(organizationService::findById)
                        .then(organization -> TestAggregate.create(command.name(), organization))
                        .then(test -> {
                            try {
                                return Result.success(testRepository.save(test));
                            } catch (Exception e) {
                                log.error(e.getMessage(), e);
                                return Result.fail(ResultAggregate.Fails.Default.of(
                                        FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения теста")));
                            }
                        }));
    }

    @Transactional
    public Result<Integer, IFailAggregate> delete(Education.Test.Delete command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> find(command.test())
                .then(testAggregate -> {
                    try {
                        testRepository.delete(testAggregate);
                        return Result.success(1);
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.fail("Ошибка удаления теста: %s".formatted(command.test().testId()))));
                    }
                }));
    }
}
