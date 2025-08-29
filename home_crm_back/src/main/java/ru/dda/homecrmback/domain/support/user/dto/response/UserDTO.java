package ru.dda.homecrmback.domain.support.user.dto.response;


import lombok.Builder;

@Builder
public record UserDTO(
        Long id,
        String phone,
        String name
) {
}
