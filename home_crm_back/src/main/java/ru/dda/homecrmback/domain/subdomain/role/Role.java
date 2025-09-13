package ru.dda.homecrmback.domain.subdomain.role;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.scope.Scope;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;

import java.util.Set;

public interface Role {

    @Builder
    record Current(
            Long roleId
    ) implements IExecute<Current> {

        public static Current of() {
            return new Current(UserContextHolder.getCurrentUser().getRoleId());
        }
    }

    @Builder
    record Find(
            Long roleId,
            Long organizationId
    ) implements IExecute<Find> {
        public static Find of(Long roleId) {
            return new Find(roleId, UserContextHolder.getCurrentUser().getOrganizationId());
        }
    }

    @Builder
    record Create(
            String name,
            String description,
            Organization.FindById organization,
            Scope.Find scopes
    ) implements IExecute<Create> {

        public static Create of(String name, String description, Set<Long> scopes) {
            return new Create(
                    name,
                    description,
                    Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()),
                    Scope.Find.of(scopes));
        }
    }

    @Builder
    record Update(
            Role.Find role,
            String name,
            String description,
            Scope.Find scopes
    ) implements IExecute<Update> {

        public static Update of(long id, String name, String description, Set<Long> scopes) {
            return new Update(Find.of(id), name, description, Scope.Find.of(scopes));
        }
    }

    @Builder
    record Delete(
            Role.Find role
    ) implements IExecute<Delete> {

        public static Delete of(long id) {
            return new Delete(Find.of(id));
        }
    }
}
