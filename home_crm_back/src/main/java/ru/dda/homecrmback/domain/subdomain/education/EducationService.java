package ru.dda.homecrmback.domain.subdomain.education;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.OptionAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.QuestionAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.education.repository.OptionRepository;
import ru.dda.homecrmback.domain.subdomain.education.repository.QuestionRepository;
import ru.dda.homecrmback.domain.subdomain.education.repository.TestRepository;
import ru.dda.homecrmback.domain.subdomain.employee.EmployeeService;
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
    private final EmployeeService employeeService;
    private final TestRepository testRepository;
    private final QuestionRepository questionRepository;
    private final OptionRepository optionRepository;

    @Transactional(readOnly = true)
    public Result<TestAggregate, IFailAggregate> findTest(Education.Test.Find command) {
        return testRepository.findByIdAndOrganizationId(command.testId(), command.organization().organizationId())
                .map(Result::<TestAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.TEST_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<TestAggregate, IFailAggregate> createTest(Education.Test.Create command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () ->
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
    public Result<TestAggregate, IFailAggregate> updateTest(Education.Test.Update command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findTest(command.test())
                .then(testAggregate -> testAggregate.update(command.name(), command.timeLimitMinutes())));
    }

    @Transactional
    public Result<TestAggregate, IFailAggregate> readyTest(Education.Test.UpdateReady command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findTest(command.test())
                .then(testAggregate -> testAggregate.ready(command.ready())));
    }

    @Transactional
    public Result<Integer, IFailAggregate> deleteTest(Education.Test.Delete command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findTest(command.test())
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

    @Transactional
    public Result<TestAggregate, IFailAggregate> assign(Education.Test.AssignCommand command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () ->
                Result.merge(
                        command.test().execute(this::findTest),
                        command.employee().execute(employeeService::find),
                        TestAggregate::assignTest));
    }

    @Transactional
    public Result<TestAggregate, IFailAggregate> unassign(Education.Test.AssignCommand command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () ->
                Result.merge(
                        command.test().execute(this::findTest),
                        command.employee().execute(employeeService::find),
                        TestAggregate::unassignTest));
    }


    @Transactional(readOnly = true)
    public Result<QuestionAggregate, IFailAggregate> findQuestion(Education.Question.Find command) {
        return questionRepository.findByIdAndOrganizationId(command.id(), command.organization().organizationId())
                .map(Result::<QuestionAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.TEST_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<QuestionAggregate, IFailAggregate> createQuestion(Education.Question.Create command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () ->
                Result.merge(
                                command.test().execute(this::findTest),
                                command.organization().execute(organizationService::findById),
                                (test, organization) -> QuestionAggregate.create(
                                        command.text(), test, organization))
                        .then(questionAggregate -> {
                            try {
                                return Result.success(questionRepository.save(questionAggregate));
                            } catch (Exception e) {
                                log.error(e.getMessage(), e);
                                return Result.fail(ResultAggregate.Fails.Default.of(
                                        FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения вопроса")));
                            }
                        }));
    }

    @Transactional
    public Result<QuestionAggregate, IFailAggregate> updateQuestion(Education.Question.Update command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findQuestion(command.question())
                .then(aggregate -> aggregate.update(command.text())));
    }

    @Transactional
    public Result<Integer, IFailAggregate> deleteQuestion(Education.Question.Delete command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findQuestion(command.question())
                .isTrue(question -> !question.getTest().isReady(),
                        question -> ResultAggregate.Fails.Default.of(FailEvent.TEST_IS_READY.fail()))
                .then(aggregate -> {
                    try {
                        questionRepository.delete(aggregate);
                        return Result.success(1);
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.fail("Ошибка удаления теста: %s".formatted(command.question().id()))));
                    }
                }));
    }

    @Transactional(readOnly = true)
    public Result<OptionAggregate, IFailAggregate> findOption(Education.Option.Find command) {
        return optionRepository.findByIdAndOrganizationId(command.id(), command.organization().organizationId())
                .map(Result::<OptionAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.TEST_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<OptionAggregate, IFailAggregate> createOption(Education.Option.Create command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () ->
                Result.merge(
                                command.question().execute(this::findQuestion),
                                command.organization().execute(organizationService::findById),
                                (question, organization) -> OptionAggregate.create(
                                        command.text(), command.correct(), question, organization))
                        .then(aggregate -> {
                            try {
                                return Result.success(optionRepository.save(aggregate));
                            } catch (Exception e) {
                                log.error(e.getMessage(), e);
                                return Result.fail(ResultAggregate.Fails.Default.of(
                                        FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения ответа на вопрос")));
                            }
                        }));
    }

    @Transactional
    public Result<OptionAggregate, IFailAggregate> updateOption(Education.Option.Update command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findOption(command.option())
                .then(aggregate -> aggregate.update(command.text(), command.correct())));
    }

    @Transactional
    public Result<Integer, IFailAggregate> deleteOption(Education.Option.Delete command) {
        return roleService.checkScope(ScopeType.TEST_CREATE, () -> findOption(command.option())
                .isTrue(option -> !option.getQuestion().getTest().isReady(),
                        option -> ResultAggregate.Fails.Default.of(FailEvent.TEST_IS_READY.fail()))
                .then(aggregate -> {
                    try {
                        optionRepository.delete(aggregate);
                        return Result.success(1);
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.fail("Ошибка удаления теста: %s".formatted(command.option().id()))));
                    }
                }));
    }
}
