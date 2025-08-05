package ru.dda.homecrmback.domain.support.result.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.support.result.dto.ErrorData;

@Builder
public record FailResponse<T>(
        T data,
        int status,
        ErrorData errorData
) implements IResponse<T> {
    public static <V> FailResponse<V> of(ErrorData errorData) {
        return FailResponse.<V>builder()
                .status(1)
                .errorData(errorData)
                .build();
    }
}
