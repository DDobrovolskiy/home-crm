package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationDTO;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserDTO;
import ru.dda.homecrmback.domain.support.role.dto.response.RoleDTO;


@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record EmployeeDTO(
        long id,
        UserDTO user,
        OrganizationDTO organization,
        RoleDTO role
) {
}
