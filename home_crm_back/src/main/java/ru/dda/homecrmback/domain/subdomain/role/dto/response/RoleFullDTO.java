package ru.dda.homecrmback.domain.subdomain.role.dto.response;

import lombok.Builder;

@Builder
public record RoleFullDTO(
        RoleDTO role,
        RoleEmployeeDTO employee,
        RoleScopesDTO scopes
) {
}
