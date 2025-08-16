package ru.dda.homecrmback.domain.support;

import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;

import java.util.function.Function;

public interface IExecute<V extends IExecute<V>> {
    default <T> Result<T, IFailAggregate> execute(Function<V, Result<T, IFailAggregate>> function) {
        return function.apply((V) this);
    }

    default <T> T map(Function<V, T> function) {
        return function.apply((V) this);
    }
}
