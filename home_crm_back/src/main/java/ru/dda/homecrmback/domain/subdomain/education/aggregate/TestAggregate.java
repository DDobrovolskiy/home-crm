package ru.dda.homecrmback.domain.subdomain.education.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    private int timeLimit;

    @NotNull
    @ManyToOne(cascade = CascadeType.ALL)
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

    public void assignTo(EmployeeAggregate employee) {
        this.employees.add(employee);
    }

    public void addQuestion(QuestionAggregate question) {
        this.questions.add(question);
        question.setTest(this); // Убедимся, что связь установлена правильно
    }
}
