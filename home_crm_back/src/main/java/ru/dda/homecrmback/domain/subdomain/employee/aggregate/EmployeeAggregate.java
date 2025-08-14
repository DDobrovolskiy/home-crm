package ru.dda.homecrmback.domain.subdomain.employee.aggregate;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;

import java.util.Objects;

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
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;
    @NotNull
    @ManyToOne
    @JoinColumn(name = "role_id")
    private RoleAggregate role;

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

    public EmployeeDTO getEmployeeDTO() {
        return EmployeeDTO.builder()
                .id(id)
                .user(user.getUserDTO())
                .organization(organization.organizationInfoDTO())
                .role(role.getRoleDTO())
                .build();
    }
}
