package ru.dda.homecrmback.domain.subdomain.education.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.*;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "test")
public class TestAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String name;

    @NotNull
    private boolean ready;

    @NotNull
    private int timeLimitMinutes;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    // Множество сотрудников, которым назначен тест
    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(
            name = "employee_test",
            joinColumns = @JoinColumn(name = "test_id"),
            inverseJoinColumns = @JoinColumn(name = "employee_id"))
    private Set<EmployeeAggregate> employees = new HashSet<>();

    // Отношения один ко многим: Тест содержит список вопросов
    @OneToMany(mappedBy = "test", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<QuestionAggregate> questions = new ArrayList<>();

    @OneToMany(mappedBy = "test", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TestSessionAggregate> sessions = new ArrayList<>();

    public static Result<TestAggregate, IFailAggregate> create(String name, OrganizationAggregate organizationAggregate) {
        return Validator.create()
                .is(Objects.nonNull(name),
                        () -> log.debug("Название теста не должно быть пусто"),
                        FailEvent.VALIDATION.fail("Название теста не должно быть пусто"))
                .is(Objects.nonNull(organizationAggregate),
                        () -> log.debug("Command.Create#organization is null"),
                        FailEvent.VALIDATION.fail("Не указана организация"))
                .getResult(() -> {
                    TestAggregate aggregate = new TestAggregate();
                    aggregate.name = name;
                    aggregate.organization = organizationAggregate;
                    aggregate.ready = false;
                    aggregate.timeLimitMinutes = 0;
                    return aggregate;
                });
    }

    public Result<TestAggregate, IFailAggregate> update(String name, int timeLimitMinutes) {
        return Validator.create()
                .is(Objects.nonNull(name),
                        () -> log.debug("Название теста не должно быть пусто"),
                        FailEvent.VALIDATION.fail("Название теста не должно быть пусто"))
                .is(timeLimitMinutes >= 0,
                        () -> log.debug("Время выполнение должно больше или равно 0"),
                        FailEvent.VALIDATION.fail("Время выполнение должно больше 0"))
                .getResult(() -> {
                    this.name = name;
                    this.timeLimitMinutes = timeLimitMinutes;
                    return this;
                });
    }

    public Result<TestAggregate, IFailAggregate> ready(boolean ready) {
        return Validator.create()
                .is(!this.questions.isEmpty(),
                        () -> log.debug("Нету вопросов в тесте"),
                        FailEvent.VALIDATION.fail("В тесте должен быть хотя бы один вопрос"))
                .is(this.questions.stream().noneMatch(questionAggregate -> Objects.nonNull(questionAggregate.getValidFail())),
                        () -> log.debug("Есть ошибки валидации вопросов"),
                        FailEvent.VALIDATION.fail(this.questions.stream()
                                .map(QuestionAggregate::getValidFail)
                                .filter(Objects::nonNull)
                                .collect(Collectors.joining(System.lineSeparator()))))
                .getResult(() -> {
                    this.ready = ready;
                    return this;
                });
    }

    public Result<TestAggregate, IFailAggregate> assignTest(EmployeeAggregate employeeAggregate) {
        return Validator.create()
                .is(Objects.nonNull(employeeAggregate),
                        () -> log.debug("Command.Create#user is null"),
                        FailEvent.VALIDATION.fail("Сотрудник не определен"))
                .is(this.isReady(),
                        () -> log.debug("При назначении тест не готов"),
                        FailEvent.VALIDATION.fail("Назначить можно только готовый тест"))
                .getResult(() -> {
                    this.getEmployees().add(employeeAggregate);
                    return this;
                });
    }

    public Result<TestAggregate, IFailAggregate> unassignTest(EmployeeAggregate employeeAggregate) {
        return Validator.create()
                .is(Objects.nonNull(employeeAggregate),
                        () -> log.debug("Command.Create#user is null"),
                        FailEvent.VALIDATION.fail("Сотрудник не определен"))
                .getResult(() -> {
                    this.getEmployees().remove(employeeAggregate);
                    return this;
                });
    }

    public EducationTestDTO getEducationTestDTO() {
        return EducationTestDTO.builder()
                .id(id)
                .name(name)
                .ready(ready)
                .timeLimitMinutes(timeLimitMinutes)
                .organization(organization.organizationDTO())
                .build();
    }

    public EducationTestEmployeesDTO getEducationTestEmployeesDTO() {
        return EducationTestEmployeesDTO.builder()
                .employees(employees.stream()
                        .map(EmployeeAggregate::getEmployeeDTO)
                        .toList())
                .build();
    }

    public EducationTestQuestionsDTO getEducationTestQuestionsDTO() {
        return EducationTestQuestionsDTO.builder()
                .questions(questions.stream()
                        .map(QuestionAggregate::getEducationQuestionViewDTO)
                        .toList())
                .build();
    }

    public EducationTestSessionsDTO getEducationTestSessionsDTO() {
        return EducationTestSessionsDTO.builder()
                .sessions(sessions.stream()
                        .map(TestSessionAggregate::getEducationTestSessionDTO)
                        .toList())
                .build();
    }

    public EducationTestViewDTO getEducationTestViewDTO() {
        return EducationTestViewDTO.builder()
                .test(getEducationTestDTO())
                .testEmployees(getEducationTestEmployeesDTO())
                .testSessions(getEducationTestSessionsDTO())
                .build();
    }

    public EducationTestEditDTO getEducationTestEditDTO() {
        return EducationTestEditDTO.builder()
                .test(getEducationTestDTO())
                .testQuestions(getEducationTestQuestionsDTO())
                .build();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        TestAggregate that = (TestAggregate) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
