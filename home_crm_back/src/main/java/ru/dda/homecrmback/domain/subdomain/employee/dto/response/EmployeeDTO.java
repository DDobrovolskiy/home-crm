package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationDTO;
import ru.dda.homecrmback.domain.support.role.dto.response.RoleDTO;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;


@Builder
public record EmployeeDTO(
        long id,
        UserAggregate.DTO.UserBaseDTO user,
        OrganizationDTO organization,
        RoleDTO role
) {
}
