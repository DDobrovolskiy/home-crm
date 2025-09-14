package ru.dda.homecrmback.domain.support.result.exception;

import lombok.Getter;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;

@Getter
public class ResultException extends Exception {
    private final IFailAggregate failAggregate;

    public ResultException(IFailAggregate failAggregate) {
        this.failAggregate = failAggregate;
    }
}
