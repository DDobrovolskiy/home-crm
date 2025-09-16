package ru.dda.homecrmback.domain.subdomain.employee;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.role.Role;
import ru.dda.homecrmback.domain.subdomain.user.User;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;

public interface Employee {

    @Builder
    record Current(
            User.FindById user,
            Organization.FindById organization
    ) implements IExecute<Current> {

        public static Current of() {
            return new Current(
                    User.FindById.of(UserContextHolder.getCurrentUser().getUserId()),
                    Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
        }
    }


    @Builder
    record Find(
            long id,
            Organization.FindById organization
    ) implements IExecute<Find> {

        public static Find of(long id) {
            return new Find(id, Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
        }
    }

    @Builder
    record Create(
            User.RegistrationOrGet user,
            Organization.FindById organization,
            Role.Find role
    ) implements IExecute<Create> {

        public static Create of(String name, String phone, String password, long roleId) {
            return new Create(
                    User.RegistrationOrGet.of(name, phone, password),
                    Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()),
                    Role.Find.of(roleId));
        }
    }

    @Builder
    record Update(
            Find employee,
            Role.Find role
    ) implements IExecute<Update> {

        public static Update of(long id, long roleId) {
            return new Update(
                    Employee.Find.of(id),
                    Role.Find.of(roleId));
        }
    }

    @Builder
    record Delete(
            Find employee
    ) implements IExecute<Delete> {

        public static Delete of(long id) {
            return new Delete(
                    Employee.Find.of(id));
        }
    }
}
