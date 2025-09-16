package ru.dda.homecrmback.domain.subdomain.education.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestResultDetailDTO;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.util.Objects;


@Slf4j
@Getter
@Setter
@Entity
@Table(name = "test_result_detail")
public class TestResultDetailAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    // Сохраняем точную формулировку вопроса на момент прохождения теста
    private String questionText;

    // Ответ, выбранный сотрудником
    private String selectedAnswer;

    // Правильный ответ на момент прохождения теста
    private String correctAnswer;

    // Флаг правильности ответа
    private boolean isCorrect;

    // Привязываем детализацию к соответствующему результату
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "result_id")
    private TestResultAggregate result;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    public static Result<TestResultDetailAggregate, IFailAggregate> create(String questionText, boolean isCorrect,
                                                                           TestResultAggregate result, OrganizationAggregate organization) {
        return Validator.create()
                .is(Objects.nonNull(result),
                        () -> log.debug("Command.Create#result is null"),
                        FailEvent.VALIDATION.fail("Не указан result"))
                .is(Objects.nonNull(organization),
                        () -> log.debug("Command.Create#organization is null"),
                        FailEvent.VALIDATION.fail("Не указана организация"))
                .getResult(() -> {
                    TestResultDetailAggregate aggregate = new TestResultDetailAggregate();
                    aggregate.organization = organization;
                    aggregate.result = result;
                    aggregate.questionText = questionText;
                    aggregate.isCorrect = isCorrect;
                    return aggregate;
                });
    }

    public EducationTestResultDetailDTO getEducationTestResultDetailDTO() {
        return EducationTestResultDetailDTO.builder()
                .id(id)
                .questionText(questionText)
                .isCorrect(isCorrect)
                .build();
    }
}
