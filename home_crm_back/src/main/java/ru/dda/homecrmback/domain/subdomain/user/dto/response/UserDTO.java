package ru.dda.homecrmback.domain.subdomain.user.dto.response;


import lombok.Builder;

@Builder
public record UserDTO(
        Long id,
        String phone,
        String name
) {
}
