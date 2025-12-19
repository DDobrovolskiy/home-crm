package ru.dda.homecrmback.domain.subdomain.role.dto;

import lombok.Builder;

import java.util.Set;

@Builder
public record RoleAggregateDTO(
        Long id,
        boolean active,
        int version,
        String name,
        String description,
        boolean owner,
        Set<Long> scopeIds
) {
}
