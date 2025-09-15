package ru.dda.homecrmback.domain.subdomain.education.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationOptionDTO;
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
@Table(name = "option")
public class OptionAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String text;

    // Является ли этот вариант правильным?
    @NotNull
    private boolean correct;

    // Обратная ссылка на связанный вопрос
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id")
    private QuestionAggregate question;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    public static Result<OptionAggregate, IFailAggregate> create(String text, boolean correct,
                                                                 QuestionAggregate questionAggregate, OrganizationAggregate organizationAggregate) {
        return Validator.create()
                .is(Objects.nonNull(text),
                        () -> log.debug("Текст вопроса не должен быть пустым"),
                        FailEvent.VALIDATION.fail("Текст вопроса не должен быть пустым"))
                .is(Objects.nonNull(organizationAggregate),
                        () -> log.debug("Command.Create#organization is null"),
                        FailEvent.VALIDATION.fail("Не указана организация"))
                .is(Objects.nonNull(questionAggregate),
                        () -> log.debug("Command.Create#questionAggregate is null"),
                        FailEvent.VALIDATION.fail("Не указана вопрос"))
                .is(!questionAggregate.getTest().isReady(),
                        () -> log.debug("Тест зафиксирован"),
                        FailEvent.VALIDATION.fail("Изменять готовый тест нельзя"))
                .getResult(() -> {
                    OptionAggregate aggregate = new OptionAggregate();
                    aggregate.text = text;
                    aggregate.correct = correct;
                    aggregate.organization = organizationAggregate;
                    aggregate.question = questionAggregate;
                    return aggregate;
                });
    }

    public Result<OptionAggregate, IFailAggregate> update(String text, boolean correct) {
        return Validator.create()
                .is(Objects.nonNull(text),
                        () -> log.debug("Текст вопроса не должен быть пустым"),
                        FailEvent.VALIDATION.fail("Текст вопроса не должен быть пустым"))
                .is(!this.question.getTest().isReady(),
                        () -> log.debug("Тест зафиксирован"),
                        FailEvent.VALIDATION.fail("Изменять готовый тест нельзя"))
                .getResult(() -> {
                    this.text = text;
                    this.correct = correct;
                    return this;
                });
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        OptionAggregate that = (OptionAggregate) o;
        return correct == that.correct && Objects.equals(text, that.text);
    }

    @Override
    public int hashCode() {
        return Objects.hash(text, correct);
    }

    public EducationOptionDTO getEducationOptionDTO() {
        return EducationOptionDTO.builder()
                .id(id)
                .text(text)
                .correct(correct)
                .question(question.getEducationQuestionDTO())
                .build();
    }
}
