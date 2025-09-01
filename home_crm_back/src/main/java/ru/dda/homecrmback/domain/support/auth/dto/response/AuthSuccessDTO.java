package ru.dda.homecrmback.domain.support.auth.dto.response;

import lombok.Builder;

@Builder
public record AuthSuccessDTO(
        String token,
        long userId
) {
}
