package ru.dda.homecrmback.domain.support.result.dto;

import lombok.Builder;

import java.util.List;

@Builder
public record ErrorData(
        List<Fail> errors
) {
    public static ErrorData of(List<Fail> errors) {
        return ErrorData.builder()
                .errors(errors)
                .build();
    }
}
