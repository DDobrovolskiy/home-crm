package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.support.role.dto.response.RoleDTO;

import java.util.List;

@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrganizationRolesDTO(
        List<RoleDTO> roles
) {
}
