package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationInfoDTO;
import ru.dda.homecrmback.domain.support.role.dto.response.RoleDTO;
import ru.dda.homecrmback.domain.support.user.dto.response.UserDTO;


@Builder
public record EmployeeDTO(
        long id,
        UserDTO user,
        OrganizationInfoDTO organization,
        RoleDTO role
) {
}
