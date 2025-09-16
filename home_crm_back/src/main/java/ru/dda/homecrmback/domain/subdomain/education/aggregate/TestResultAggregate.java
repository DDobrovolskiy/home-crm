package ru.dda.homecrmback.domain.subdomain.education.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.request.EducationTestSessionResultQuestionDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestResultDTO;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.time.Clock;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "test_result")
public class TestResultAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private LocalDateTime completedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private EmployeeAggregate employee;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    private TestAggregate originalTest;

    @OneToOne
    @JoinColumn(name = "session_id")
    private TestSessionAggregate session;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    // Детали всех пройденных вопросов и ответов
    @OneToMany(mappedBy = "result", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TestResultDetailAggregate> details = new ArrayList<>();

    public static Result<TestResultAggregate, IFailAggregate> create(List<EducationTestSessionResultQuestionDTO> questions,
                                                                     TestSessionAggregate session, TestAggregate test,
                                                                     EmployeeAggregate employee, OrganizationAggregate organization) {
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
                .is(Objects.nonNull(session),
                        () -> log.debug("Command.Create#session is null"),
                        FailEvent.VALIDATION.fail("Не указана session"))
                .getResult(() -> {
                    TestResultAggregate aggregate = new TestResultAggregate();
                    aggregate.completedAt = LocalDateTime.now(Clock.systemUTC());
                    aggregate.employee = employee;
                    aggregate.organization = organization;
                    aggregate.originalTest = test;
                    aggregate.session = session;
                    return aggregate;
                })
                .then(result -> Result.extract(questions.stream().map(
                                q -> TestResultDetailAggregate.create(q, result, organization)
                        ).toList())
                        .map(list -> result));
    }

    public EducationTestResultDTO getEducationTestResultDTO() {
        return EducationTestResultDTO.builder()
                .id(id)
                .completedAt(completedAt)
                .test(originalTest.getEducationTestDTO())
                .session(session.getEducationTestSessionDTO())
                .details(details.stream()
                        .map(TestResultDetailAggregate::getEducationTestResultDetailDTO)
                        .toList())
                .build();
    }
}
