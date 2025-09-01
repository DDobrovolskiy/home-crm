package ru.dda.homecrmback.domain.subdomain.employee;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.user.User;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.role.Role;

public interface Employee {

    @Builder
    record Registration(
            User.RegistrationOrGet user,
            Organization.FindById organization,
            Role.FindByIdAndOrganizationId role
    ) implements IExecute<Registration> {

        public static Registration of(String name, String phone, String password, long roleId) {
            return new Registration(
                    User.RegistrationOrGet.of(name, phone, password),
                    Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()),
                    Role.FindByIdAndOrganizationId.of(roleId, UserContextHolder.getCurrentUser().getOrganizationId()));
        }
    }
}
