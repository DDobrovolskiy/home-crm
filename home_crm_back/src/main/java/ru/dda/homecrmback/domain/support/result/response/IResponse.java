package ru.dda.homecrmback.domain.support.result.response;

import ru.dda.homecrmback.domain.support.result.dto.ErrorData;

public interface IResponse<T> {
    T data();

    int status();

    ErrorData errorData();
}
