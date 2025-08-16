package ru.dda.homecrmback.domain.subdomain.education.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

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
}
