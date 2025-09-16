package ru.dda.homecrmback.domain.subdomain.employee.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestResultAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestSessionAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeTestViewDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeTestsDTO;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.subdomain.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.util.*;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "employee")
public class EmployeeAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private UserAggregate user;
    @NotNull
    @Fetch(FetchMode.JOIN)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;
    @NotNull
    @Fetch(FetchMode.JOIN)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id")
    private RoleAggregate role;
    // Сотрудник может проходить несколько тестов
    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY)
    @JoinTable(
            name = "employee_test",
            joinColumns = @JoinColumn(name = "employee_id"),
            inverseJoinColumns = @JoinColumn(name = "test_id"))
    private Set<TestAggregate> assignedTests = new HashSet<>();
    // Много результатов принадлежит одному сотруднику
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TestResultAggregate> results = new ArrayList<>();
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TestSessionAggregate> sessions = new ArrayList<>();

    public static Result<EmployeeAggregate, IFailAggregate> create(UserAggregate userAggregate,
                                                                   OrganizationAggregate organizationAggregate,
                                                                   RoleAggregate roleAggregate) {
        return Validator.create()
                .is(Objects.nonNull(userAggregate),
                        () -> log.debug("Command.Create#user is null"),
                        FailEvent.VALIDATION.fail("Сотрудник не определен"))
                .is(Objects.nonNull(organizationAggregate),
                        () -> log.debug("Command.Create#organization is null"),
                        FailEvent.VALIDATION.fail("У сотрудника не определена организация"))
                .is(Objects.nonNull(roleAggregate),
                        () -> log.debug("Command.Create#role is null"),
                        FailEvent.VALIDATION.fail("У сотрудника не определена роль"))
                .getResult(() -> {
                    EmployeeAggregate aggregate = new EmployeeAggregate();
                    aggregate.user = userAggregate;
                    aggregate.organization = organizationAggregate;
                    aggregate.role = roleAggregate;
                    return aggregate;
                });
    }

    public Result<EmployeeAggregate, IFailAggregate> update(RoleAggregate roleAggregate) {
        this.role = roleAggregate;
        return Result.success(this);
    }

    public EmployeeDTO getEmployeeDTO() {
        return EmployeeDTO.builder()
                .id(id)
                .user(user.getUserDTO())
                .organization(organization.organizationDTO())
                .role(role.getRoleDTO())
                .build();
    }

    public EmployeeTestsDTO getEmployeeTestsDTO() {
        return EmployeeTestsDTO.builder()
                .tests(assignedTests.stream()
                        .map(TestAggregate::getEducationTestDTO)
                        .toList())
                .build();
    }

    public EmployeeTestViewDTO getEmployeeTestViewDTO() {
        return EmployeeTestViewDTO.builder()
                .employee(getEmployeeDTO())
                .employeeTests(getEmployeeTestsDTO())
                .build();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        EmployeeAggregate that = (EmployeeAggregate) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
