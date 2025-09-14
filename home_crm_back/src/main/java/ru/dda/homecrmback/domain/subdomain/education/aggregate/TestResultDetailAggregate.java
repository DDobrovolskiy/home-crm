package ru.dda.homecrmback.domain.subdomain.education.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;


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
}
