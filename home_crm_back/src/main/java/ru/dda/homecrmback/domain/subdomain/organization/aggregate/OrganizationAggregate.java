package ru.dda.homecrmback.domain.subdomain.organization.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.BatchSize;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.*;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.subdomain.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.support.aggregete.IAggregate;
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
@Table(name = "organization")
public class OrganizationAggregate implements IAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String name;
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id")
    private UserAggregate owner;
    @OneToMany(mappedBy = "organization", cascade = {CascadeType.ALL}, orphanRemoval = true)
    @BatchSize(size = 20)
    private List<EmployeeAggregate> employees = new ArrayList<>();
    @OneToMany(mappedBy = "organization", cascade = {CascadeType.ALL}, orphanRemoval = true)
    @BatchSize(size = 20)
    private List<RoleAggregate> roles = new ArrayList<>();
    @OneToMany(mappedBy = "organization", cascade = {CascadeType.ALL}, orphanRemoval = true)
    @BatchSize(size = 20)
    private List<TestAggregate> tests = new ArrayList<>();

    public static Result<OrganizationAggregate, IFailAggregate> create(UserAggregate owner, String name) {
        return Validator.create()
                .is(StringUtils.hasText(name),
                        () -> log.debug("Command.Create#organizationName is null"),
                        FailEvent.VALIDATION.fail("Имя организации не заполнено"))
                .is(Objects.nonNull(owner),
                        () -> log.debug("Command.Create#owner is null"),
                        FailEvent.VALIDATION.fail("Владелец организации не заполнен"))
                .then(() -> {
                    OrganizationAggregate aggregate = new OrganizationAggregate();
                    aggregate.name = name;
                    aggregate.owner = owner;
                    return RoleAggregate.createOwner(aggregate)
                            .then(role -> {
                                aggregate.addRole(role);
                                return EmployeeAggregate.create(owner, aggregate, role);
                            })
                            .map(boss -> {
                                aggregate.employees.add(boss);
                                return aggregate;
                            });
                });
    }

    public Result<OrganizationAggregate, IFailAggregate> update(Organization.Update update) {
        return Validator.create()
                .is(StringUtils.hasText(update.organizationName()),
                        () -> log.debug("Command.Create#organizationName is null"),
                        FailEvent.VALIDATION.fail("Имя организации не заполнено"))
                .getResult(() -> {
                    this.name = update.organizationName();
                    return this;
                });
    }

    public OrganizationAggregate addRole(RoleAggregate role) {
        this.roles.add(role);
        return this;
    }

    public OrganizationDTO organizationDTO() {
        return OrganizationDTO.builder()
                .id(id)
                .name(name)
                .owner(owner.getUserDTO())
                .build();
    }

    public OrganizationEmployeesDTO organizationEmployeesDTO() {
        return OrganizationEmployeesDTO.builder()
                .employees(employees.stream()
                        .sorted(IAggregate::compareTo)
                        .map(EmployeeAggregate::getEmployeeDTO)
                        .toList())
                .build();
    }

    public OrganizationRolesDTO organizationRolesDTO() {
        return OrganizationRolesDTO.builder()
                .roles(roles.stream()
                        .sorted(IAggregate::compareTo)
                        .map(RoleAggregate::getRoleFullDTO)
                        .toList())
                .build();
    }

    public OrganizationTestsDTO getOrganizationTestsDTO() {
        return OrganizationTestsDTO.builder()
                .tests(tests.stream()
                        .map(TestAggregate::getEducationTestViewDTO)
                        .toList())
                .build();
    }

    public OrganizationEmployeesTestsDTO getOrganizationEmployeesTestsDTO() {
        return OrganizationEmployeesTestsDTO.builder()
                .employees(employees.stream()
                        .sorted(IAggregate::compareTo)
                        .map(EmployeeAggregate::getEmployeeTestViewDTO)
                        .toList())
                .build();
    }
}
