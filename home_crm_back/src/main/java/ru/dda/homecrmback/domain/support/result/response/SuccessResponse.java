package ru.dda.homecrmback.domain.support.result.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.support.result.dto.ErrorData;

@Builder
public record SuccessResponse<T>(
        T data,
        int status,
        ErrorData errorData
) implements IResponse<T> {
    public static <V> SuccessResponse<V> of(final V data) {
        return SuccessResponse.<V>builder()
                .data(data)
                .status(0)
                .build();
    }
}
