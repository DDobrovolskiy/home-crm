package ru.dda.homecrmback.domain.subdomain.education.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestSessionDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestSessionQuestionsDTO;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.time.Clock;
import java.time.LocalDateTime;
import java.util.Objects;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "test_sessions")
public class TestSessionAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // Начало и конец сеанса прохождения теста
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    // Сеанс прохождения относится к конкретному сотруднику
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private EmployeeAggregate employee;

    // Сеанс прохождения основан на конкретном тесте
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    private TestAggregate test;

    @OneToOne
    @JoinColumn(name = "result_id")
    private TestResultAggregate result;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    public static Result<TestSessionAggregate, IFailAggregate> create(TestAggregate test, EmployeeAggregate employee, OrganizationAggregate organization) {
        return Validator.create()
                .is(Objects.nonNull(test),
                        () -> log.debug("Command.Create#test is null"),
                        FailEvent.VALIDATION.fail("Не указан тест"))
                .is(Objects.nonNull(employee),
                        () -> log.debug("Command.Create#employee is null"),
                        FailEvent.VALIDATION.fail("Не указан сотрудник"))
                .is(Objects.nonNull(organization),
                        () -> log.debug("Command.Create#organization is null"),
                        FailEvent.VALIDATION.fail("Не указана организация"))
                .is(test.isReady(),
                        () -> log.debug("Тест должен быть готов"),
                        FailEvent.VALIDATION.fail("Тест должен быть готов"))
                .is(test.getEmployees().contains(employee),
                        () -> log.debug("Тест не назначен на сотрудника"),
                        FailEvent.VALIDATION.fail("Тест не назначен на сотрудника"))
                .getResult(() -> {
                    TestSessionAggregate aggregate = new TestSessionAggregate();
                    aggregate.startTime = LocalDateTime.now(Clock.systemUTC());
                    if (test.getTimeLimitMinutes() != 0) {
                        aggregate.endTime = LocalDateTime.now(Clock.systemUTC()).plusMinutes(test.getTimeLimitMinutes());
                    }
                    aggregate.employee = employee;
                    aggregate.organization = organization;
                    aggregate.test = test;
                    test.getEmployees().remove(employee);
                    return aggregate;
                });
    }

    public EducationTestSessionDTO getEducationTestSessionDTO() {
        return EducationTestSessionDTO.builder()
                .id(id)
                .startTime(startTime)
                .endTime(endTime)
                .employee(employee.getEmployeeDTO())
                .test(test.getEducationTestDTO())
                .active(endTime == null || LocalDateTime.now().isBefore(endTime))
                .build();
    }

    public EducationTestSessionQuestionsDTO getEducationTestSessionQuestionsDTO() {
        return EducationTestSessionQuestionsDTO.builder()
                .session(getEducationTestSessionDTO())
                .test(test.getRunEducationTestQuestionsDTO())
                .build();
    }
}
