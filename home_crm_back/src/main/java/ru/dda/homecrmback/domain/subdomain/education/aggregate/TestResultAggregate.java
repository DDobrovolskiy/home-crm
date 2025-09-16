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
import java.util.Set;
import java.util.stream.Collectors;

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

    @OneToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
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
                .then(result -> {
                    var map = questions.stream().collect(Collectors.toMap(
                            EducationTestSessionResultQuestionDTO::questionId,
                            EducationTestSessionResultQuestionDTO::options));
                    return Result.extract(result.originalTest.getQuestions().stream().map(q -> {
                                Set<Long> answers = map.get(q.getId());
                                boolean correct = answers != null && answers.containsAll(q.getOptions().stream()
                                        .filter(OptionAggregate::isCorrect)
                                        .map(OptionAggregate::getId)
                                        .toList());
                                return TestResultDetailAggregate.create(q.getText(), correct, result, organization);
                            }).toList())
                            .map(result::setDetails);
                });
    }

    private TestResultAggregate setDetails(List<TestResultDetailAggregate> details) {
        this.details = details;
        return this;
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
