package ru.dda.homecrmback.domain.subdomain.user.dto.response;

import lombok.Builder;

@Builder
public record UserAggregateDTO(
        Long id,
        boolean active,
        int version,
        String createdAt,
        String name,
        String surname,
        String patronymic,
        String phone
) {
}
