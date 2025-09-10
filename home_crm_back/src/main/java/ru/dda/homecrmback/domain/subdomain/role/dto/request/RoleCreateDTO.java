package ru.dda.homecrmback.domain.subdomain.role.dto.request;

import java.util.Set;

public record RoleCreateDTO(
        String name,
        String description,
        Set<Long> scopes
) {
}
