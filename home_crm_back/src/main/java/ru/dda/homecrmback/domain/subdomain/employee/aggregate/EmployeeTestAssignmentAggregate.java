package ru.dda.homecrmback.domain.subdomain.employee.aggregate;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.enums.AssignmentStatus;

import java.io.Serializable;
import java.time.LocalDateTime;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "employee_test_assignments")
public class EmployeeTestAssignmentAggregate {
    @EmbeddedId
    private EmployeeTestAssignmentPK id;

    // Срок выполнения теста
    private LocalDateTime deadline;

    // Дополнительно можем добавить статус прохождения ("не начат", "проходит", "завершен").
    private AssignmentStatus status;

    @Slf4j
    @Getter
    @Setter
    @Embeddable
    static class EmployeeTestAssignmentPK implements Serializable {

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "employee_id")
        private EmployeeAggregate employee;

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "test_id")
        private TestAggregate test;
    }
}


