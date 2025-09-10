package ru.dda.homecrmback.domain.subdomain.role.dto.request;

import java.util.Set;

public record RoleUpdateDTO(
        long id,
        String name,
        String description,
        Set<Long> scopes
) {
}
