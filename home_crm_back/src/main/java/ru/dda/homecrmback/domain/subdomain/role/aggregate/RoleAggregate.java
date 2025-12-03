package ru.dda.homecrmback.domain.subdomain.role.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.BatchSize;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleEmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleFullDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleScopesDTO;
import ru.dda.homecrmback.domain.subdomain.scope.aggregate.ScopeAggregate;
import ru.dda.homecrmback.domain.subdomain.scope.enums.ScopeType;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.util.*;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "role")
public class RoleAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String name;
    private String description;
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;
    @OneToMany(mappedBy = "role", cascade = {CascadeType.MERGE, CascadeType.PERSIST}, fetch = FetchType.LAZY)
    @BatchSize(size = 20)
    private List<EmployeeAggregate> employees = new ArrayList<>();
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "role_scopes",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "scopes_id"))
    private Set<ScopeAggregate> scopes = new HashSet<>();
    @NotNull
    private boolean owner;

    public static Result<RoleAggregate, IFailAggregate> create(String name, String description, OrganizationAggregate organization, Set<ScopeAggregate> scopes) {
        return Validator.create()
                .is(StringUtils.hasText(name),
                        () -> log.debug("RoleDto#organizationName is null"),
                        FailEvent.VALIDATION.fail("Название роли не заполнено"))
                .is(Objects.nonNull(organization),
                        () -> log.debug("RoleDto#organization is null"),
                        FailEvent.VALIDATION.fail("Организация у роли не заполнено"))
                .getResult(() -> {
                    RoleAggregate aggregate = new RoleAggregate();
                    aggregate.name = name;
                    aggregate.description = description;
                    aggregate.organization = organization;
                    aggregate.scopes = scopes;
                    aggregate.owner = false;
                    return aggregate;
                });
    }

    public static Result<RoleAggregate, IFailAggregate> createOwner(OrganizationAggregate organization) {
        return Validator.create()
                .is(Objects.nonNull(organization),
                        () -> log.debug("RoleDto#organization is null"),
                        FailEvent.VALIDATION.fail("Организация у роли не заполнено"))
                .getResult(() -> {
                    RoleAggregate aggregate = new RoleAggregate();
                    aggregate.name = "Владелец";
                    aggregate.description = "Владелец организации";
                    aggregate.organization = organization;
                    aggregate.owner = true;
                    return aggregate;
                });
    }

    public Result<RoleAggregate, IFailAggregate> update(String name, String description, Set<ScopeAggregate> scopes) {
        return Validator.create()
                .is(StringUtils.hasText(name),
                        () -> log.debug("Название роли не должно быть пустым"),
                        FailEvent.VALIDATION.fail("Название роли не должно быть пустым"))
                .getResult(() -> {
                    this.name = name;
                    this.description = description;
                    this.scopes = scopes;
                    return this;
                });
    }

    public boolean roleHasScope(ScopeType scopeType) {
        return this.getScopes().stream()
                .anyMatch(scopeAggregate -> scopeAggregate.getType().equals(scopeType));
    }

    public void addEmployee(EmployeeAggregate employee) {
        this.employees.add(employee);
    }

    public RoleDTO getRoleDTO() {
        return RoleDTO.builder()
                .id(id)
                .name(name)
                .description(description)
                .owner(owner)
                .build();
    }

    public RoleScopesDTO getRoleScopesDTO() {
        return RoleScopesDTO.builder()
                .scopes(scopes.stream()
                        .map(ScopeAggregate::getScopeDTO)
                        .toList())
                .build();
    }

    public RoleEmployeeDTO getRoleEmployeesDTO() {
        return RoleEmployeeDTO.builder()
                .employees(employees.stream()
                        .map(EmployeeAggregate::getEmployeeDTO)
                        .toList())
                .build();
    }

    public RoleFullDTO getRoleFullDTO() {
        return RoleFullDTO.builder()
                .role(getRoleDTO())
                .roleEmployee(getRoleEmployeesDTO())
                .roleScopes(getRoleScopesDTO())
                .build();
    }
}
