package ru.dda.homecrmback.domain.subdomain.organization.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "organization")
public class OrganizationAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String name;
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id")
    private UserAggregate owner;
    @OneToMany(mappedBy = "organization", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<EmployeeAggregate> employees = new ArrayList<>();
    @OneToMany(mappedBy = "organization", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<RoleAggregate> roles = new ArrayList<>();
    @OneToMany(mappedBy = "organization", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<TestAggregate> tests = new ArrayList<>();

    public static Result<OrganizationAggregate, IFailAggregate> create(UserAggregate owner, String name) {
        return Validator.create()
                .is(StringUtils.hasText(name),
                        () -> log.debug("Command.Create#organizationName is null"),
                        FailEvent.VALIDATION.fail("Имя организации не заполнено"))
                .is(Objects.nonNull(owner),
                        () -> log.debug("Command.Create#owner is null"),
                        FailEvent.VALIDATION.fail("Владелец организации не заполнен"))
                .getResult(() -> {
                    OrganizationAggregate aggregate = new OrganizationAggregate();
                    aggregate.name = name;
                    aggregate.owner = owner;
                    return aggregate;
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

    public void addTest(TestAggregate test) {
        this.tests.add(test);
        test.setOrganization(this);
    }

    public OrganizationDTO organizationInfoDTO() {
        return OrganizationDTO.builder()
                .id(id)
                .name(name)
                .owner(owner.getUserDTO())
                .build();
    }
}
