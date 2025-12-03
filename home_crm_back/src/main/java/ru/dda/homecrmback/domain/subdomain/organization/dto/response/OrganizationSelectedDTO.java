package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleDTO;

@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrganizationSelectedDTO(
        OrganizationDTO organization,
        RoleDTO role
) {
}
