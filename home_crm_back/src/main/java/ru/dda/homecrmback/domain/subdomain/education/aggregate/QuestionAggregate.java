package ru.dda.homecrmback.domain.subdomain.education.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionOptionsDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionViewDTO;

import java.util.ArrayList;
import java.util.List;

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

    @NotNull
    private boolean oneAnswer;

    // Связь с тестом (один ко многим)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    private TestAggregate test;

    // Список возможных вариантов ответов
    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OptionAggregate> options = new ArrayList<>();

    public void addOption(OptionAggregate option) {
        this.options.add(option);
        option.setQuestion(this); // Установим обратную ссылку
    }

    public EducationQuestionDTO getEducationQuestionDTO() {
        return EducationQuestionDTO.builder()
                .id(id)
                .text(text)
                .oneAnswer(oneAnswer)
                .test(test.getEducationTestDTO())
                .build();
    }

    public EducationQuestionOptionsDTO getEducationQuestionOptionsDTO() {
        return EducationQuestionOptionsDTO.builder()
                .options(options.stream()
                        .map(OptionAggregate::getEducationOptionDTO)
                        .toList())
                .build();
    }

    public EducationQuestionViewDTO getEducationQuestionViewDTO() {
        return EducationQuestionViewDTO.builder()
                .question(getEducationQuestionDTO())
                .questionOptions(getEducationQuestionOptionsDTO())
                .build();
    }
}
