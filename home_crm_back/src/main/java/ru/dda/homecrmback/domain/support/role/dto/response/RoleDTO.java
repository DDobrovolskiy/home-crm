package ru.dda.homecrmback.domain.support.role.dto.response;

import lombok.Builder;

@Builder
public record RoleDTO(
        long id,
        String name,
        String description
) {
}
