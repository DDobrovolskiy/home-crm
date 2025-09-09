package ru.dda.homecrmback.domain.subdomain.employee;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.user.User;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.role.Role;

public interface Employee {

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
            Role.FindByIdAndOrganizationId role
    ) implements IExecute<Create> {

        public static Create of(String name, String phone, String password, long roleId) {
            return new Create(
                    User.RegistrationOrGet.of(name, phone, password),
                    Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()),
                    Role.FindByIdAndOrganizationId.of(roleId, UserContextHolder.getCurrentUser().getOrganizationId()));
        }
    }

    @Builder
    record Update(
            Find employee,
            Role.FindByIdAndOrganizationId role
    ) implements IExecute<Update> {

        public static Update of(long id, long roleId) {
            return new Update(
                    Employee.Find.of(id),
                    Role.FindByIdAndOrganizationId.of(roleId, UserContextHolder.getCurrentUser().getOrganizationId()));
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
