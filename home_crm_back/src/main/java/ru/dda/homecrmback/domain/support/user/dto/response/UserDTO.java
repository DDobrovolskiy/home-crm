package ru.dda.homecrmback.domain.support.user.dto.response;

import lombok.Builder;

@Builder
public record UserDTO(
        long id,
        String phone,
        String name
) {
}
