package ru.dda.homecrmback.domain.subdomain.education.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.Education;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionOptionsDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionViewDTO;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "question")
public class QuestionAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String text;

    // Связь с тестом (один ко многим)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    private TestAggregate test;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    // Список возможных вариантов ответов
    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OptionAggregate> options = new ArrayList<>();

    public static Result<QuestionAggregate, IFailAggregate> create(String text, List<Education.Option.Create> options,
                                                                   TestAggregate testAggregate, OrganizationAggregate organizationAggregate) {
        return Validator.create()
                .is(Objects.nonNull(text),
                        () -> log.debug("Текст вопроса не должен быть пустым"),
                        FailEvent.VALIDATION.fail("Текст вопроса не должен быть пустым"))
                .is(Objects.nonNull(organizationAggregate),
                        () -> log.debug("Не указана организация"),
                        FailEvent.VALIDATION.fail("Не указана организация"))
                .getResult(() -> {
                    QuestionAggregate aggregate = new QuestionAggregate();
                    aggregate.text = text;
                    aggregate.organization = organizationAggregate;
                    aggregate.test = testAggregate;
                    return aggregate;
                })
                .then(question -> Result.extract(options.stream()
                                .map(create -> OptionAggregate.create(create.text(), create.correct(), question, organizationAggregate))
                                .toList())
                        .then(optionList -> Validator.create()
                                .is(!optionList.isEmpty(),
                                        () -> log.debug("Количество ответов не должно быть меньше 1"),
                                        FailEvent.VALIDATION.fail("Количество ответов не должно быть меньше 1"))
                                .is(optionList.stream().anyMatch(OptionAggregate::isCorrect),
                                        () -> log.debug("Не указан ответ"),
                                        FailEvent.VALIDATION.fail("Не указан ответ"))
                                .getResult(() -> {
                                    question.options = optionList;
                                    return question;
                                })));
    }

    public static Result<QuestionAggregate, IFailAggregate> create(String text, TestAggregate testAggregate, OrganizationAggregate organizationAggregate) {
        return Validator.create()
                .is(Objects.nonNull(text),
                        () -> log.debug("Текст вопроса не должен быть пустым"),
                        FailEvent.VALIDATION.fail("Текст вопроса не должен быть пустым"))
                .is(Objects.nonNull(organizationAggregate),
                        () -> log.debug("Не указана организация"),
                        FailEvent.VALIDATION.fail("Не указана организация"))
                .getResult(() -> {
                    QuestionAggregate aggregate = new QuestionAggregate();
                    aggregate.text = text;
                    aggregate.organization = organizationAggregate;
                    aggregate.test = testAggregate;
                    return aggregate;
                });
    }

    public Result<QuestionAggregate, IFailAggregate> update(String text) {
        return Validator.create()
                .is(Objects.nonNull(text),
                        () -> log.debug("Текст вопроса не должен быть пустым"),
                        FailEvent.VALIDATION.fail("Текст вопроса не должен быть пустым"))
                .getResult(() -> {
                    this.text = text;
                    return this;
                });
    }

    @Transient
    public String getValidFail() {
        if (options.size() < 2) {
            return "В вопросе: %s - %s".formatted(text, getValidMessage());
        } else {
            return null;
        }
    }

    @Transient
    public String getValidMessage() {
        if (options.size() < 2) {
            return "меньше двух ответов";
        } else {
            return null;
        }
    }

    public EducationQuestionDTO getEducationQuestionDTO() {
        return EducationQuestionDTO.builder()
                .id(id)
                .text(text)
                .test(test.getEducationTestDTO())
                .build();
    }

    public EducationQuestionOptionsDTO getEducationQuestionOptionsDTO() {
        return EducationQuestionOptionsDTO.builder()
                .oneAnswer(options.stream()
                        .filter(OptionAggregate::isCorrect)
                        .count() == 1)
                .options(options.stream()
                        .map(OptionAggregate::getEducationOptionDTO)
                        .toList())
                .validMessage(getValidMessage())
                .build();
    }

    public EducationQuestionViewDTO getEducationQuestionViewDTO() {
        return EducationQuestionViewDTO.builder()
                .question(getEducationQuestionDTO())
                .questionOptions(getEducationQuestionOptionsDTO())
                .build();
    }
}
