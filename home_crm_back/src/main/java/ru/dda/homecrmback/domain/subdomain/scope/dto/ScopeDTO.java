package ru.dda.homecrmback.domain.subdomain.scope.dto;

import lombok.Builder;

@Builder
public record ScopeDTO(
        Long id,
        String name,
        String description
) {
}
