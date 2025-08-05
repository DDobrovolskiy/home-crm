package ru.dda.homecrmback.domain.support.auth.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;


public record SimpleAuthDTO(
        @NotBlank
        @Pattern(regexp = "^(\\+7)(\\s\\(\\d{3}\\)\\s)(\\d{3}-\\d{2}-\\d{2}$)")
        String phone,
        @NotBlank
        @Size(min = 1)
        String password
) {
}
