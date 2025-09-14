package ru.dda.homecrmback.domain.subdomain.education.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestSessionDTO;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;

import java.time.LocalDateTime;

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
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private EmployeeAggregate employee;

    // Сеанс прохождения основан на конкретном тесте
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id")
    private TestAggregate test;

    @NotNull
    @ManyToOne()
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    public EducationTestSessionDTO getEducationTestSessionDTO() {
        return EducationTestSessionDTO.builder()
                .id(id)
                .startTime(startTime)
                .endTime(endTime)
                .employee(employee.getEmployeeDTO())
                .test(test.getEducationTestDTO())
                .build();
    }
}
