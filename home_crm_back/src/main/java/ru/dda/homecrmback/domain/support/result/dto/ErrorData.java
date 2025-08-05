package ru.dda.homecrmback.domain.support.result.dto;

import lombok.Builder;

@Builder
public record ErrorData(
        String message
) {
    public static ErrorData of(String message) {
        return ErrorData.builder()
                .message(message)
                .build();
    }
}
