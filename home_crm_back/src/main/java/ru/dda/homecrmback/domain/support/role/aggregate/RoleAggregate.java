package ru.dda.homecrmback.domain.support.role.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;
import ru.dda.homecrmback.domain.support.role.dto.response.RoleDTO;
import ru.dda.homecrmback.domain.support.scope.ScopeType;
import ru.dda.homecrmback.domain.support.scope.aggregate.ScopeAggregate;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

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
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;
    @ManyToMany()
    @JoinTable(name = "role_scopes",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "scopes_id"))
    private Set<ScopeAggregate> scopes = new HashSet<>();

    public static Result<RoleAggregate, IFailAggregate> create(Command.Create command) {
        return Validator.create()
                .is(Objects.nonNull(command),
                        () -> log.debug("RoleDto dto is null"),
                        FailEvent.VALIDATION.fail("Переданный объект пустой"),
                        next -> next
                                .is(StringUtils.hasText(command.name),
                                        () -> log.debug("RoleDto#organizationName is null"),
                                        FailEvent.VALIDATION.fail("Название роли не заполнено"))
                                .is(Objects.nonNull(command.organization),
                                        () -> log.debug("RoleDto#organization is null"),
                                        FailEvent.VALIDATION.fail("Организация у роли не заполнено"))
                )
                .getResult(() -> {
                    RoleAggregate aggregate = new RoleAggregate();
                    aggregate.name = command.name;
                    aggregate.description = command.description;
                    aggregate.organization = command.organization;
                    return aggregate;
                });
    }

    public Result<RoleAggregate, IFailAggregate> update(Command.Update command) {
        return Validator.create()
                .is(StringUtils.hasText(command.name),
                        () -> log.debug("Название роли не должно быть пустым"),
                        FailEvent.VALIDATION.fail("Название роли не должно быть пустым"))
                .getResult(() -> {
                    this.name = command.name;
                    this.description = command.description;
                    return this;
                });
    }

    public boolean roleHasScope(ScopeType scopeType) {
        return this.getScopes().stream()
                .anyMatch(scopeAggregate -> scopeAggregate.getType().equals(scopeType));
    }

    public RoleDTO getRoleDTO() {
        return RoleDTO.builder()
                .id(id)
                .name(name)
                .description(description)
                .build();
    }

    public interface Command {

        @Builder
        record Create(
                String name,
                String description,
                OrganizationAggregate organization
        ) {
            public Result<RoleAggregate, IFailAggregate> execute() {
                return RoleAggregate.create(this);
            }
        }

        @Builder
        record Update(
                String name,
                String description
        ) {
            public Result<RoleAggregate, IFailAggregate> execute(RoleAggregate role) {
                return role.update(this);
            }
        }
    }
}
