package ru.dda.homecrmback.domain.support.result;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.support.result.dto.ErrorData;
import ru.dda.homecrmback.domain.support.result.response.FailResponse;
import ru.dda.homecrmback.domain.support.result.response.IResponse;
import ru.dda.homecrmback.domain.support.result.response.SuccessResponse;

import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;


@Slf4j
@RequiredArgsConstructor
public class Result<S, F> {
    private final S value;
    private final F error;

    public static <S, F> Result<S, F> success(S value) {
        return new Result<>(value, null);
    }

    public static <S, F> Result<S, F> fail(F fail) {
        return new Result<>(null, fail);
    }

    boolean isSuccess() {
        return error == null;
    }

    public Result<S, F> isTrue(Predicate<S> flag, Function<S, F> onError) {
        if (isSuccess() && flag.test(value)) {
            return this;
        }
        return fail(onError.apply(value));
    }

    public <S1> Result<S1, F> then(Function<S, Result<S1, F>> function) {
        if (isSuccess()) {
            return function.apply(value);
        }
        return fail(error);
    }

    public <S1, F1> Result<S1, F1> then(Function<S, Result<S1, F1>> onSuccess, Function<F, Result<S1, F1>> onFail) {
        if (isSuccess()) {
            return onSuccess.apply(value);
        }
        return onFail.apply(error);
    }

    public <S1> Result<S1, F> map(Function<S, S1> function) {
        if (isSuccess()) {
            return success(function.apply(value));
        }
        return fail(error);
    }

    public void consumer(ConsumerThrow<S> onSuccess, ConsumerThrow<F> onFail) {
        try {
            if (isSuccess()) {
                onSuccess.acceptThrow(value);
            } else {
                onFail.acceptThrow(error);
            }
        } catch (Exception e) {
            log.error(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public Result<S, F> peek(Consumer<S> onSuccess) {
        if (isSuccess()) {
            onSuccess.accept(value);
        }
        return this;
    }

    public <R> R complite(Function<S, R> onSuccess, Function<F, R> onFail) {
        if (isSuccess()) {
            return onSuccess.apply(value);
        }
        return onFail.apply(error);
    }

    public IResponse<S> response(Function<F, ErrorData> convert) {
        if (isSuccess()) {
            return SuccessResponse.of(value);
        }
        return FailResponse.of(convert.apply(error));
    }

    @FunctionalInterface
    public interface ConsumerThrow<T> {
        void acceptThrow(T t) throws Exception;
    }
}
