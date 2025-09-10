package ru.dda.homecrmback.domain.subdomain.role.dto.response;

import lombok.Builder;

@Builder
public record RoleDTO(
        long id,
        String name,
        String description
) {
}
