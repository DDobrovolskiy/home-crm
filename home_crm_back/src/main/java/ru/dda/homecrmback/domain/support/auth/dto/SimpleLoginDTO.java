package ru.dda.homecrmback.domain.support.auth.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record SimpleLoginDTO(
        @NotBlank
        @Pattern(regexp = "^(\\+7)(\\s\\(\\d{3}\\)\\s)(\\d{3}-\\d{2}-\\d{2}$)")
        String phone,
        @NotBlank
        String password
) {
}
