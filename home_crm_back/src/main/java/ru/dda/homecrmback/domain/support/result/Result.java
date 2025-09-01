package ru.dda.homecrmback.domain.support.result;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.dto.ErrorData;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.response.FailResponse;
import ru.dda.homecrmback.domain.support.result.response.IResponse;
import ru.dda.homecrmback.domain.support.result.response.SuccessResponse;
import ru.dda.homecrmback.domain.support.role.Role;
import ru.dda.homecrmback.domain.support.role.RoleService;
import ru.dda.homecrmback.domain.support.scope.ScopeType;

import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;


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

    public Result<S, F> thenIf(Predicate<S> flag, Function<S, Result<S, F>> function) {
        if (isSuccess()) {
            if (flag.test(value)) {
                return function.apply(value);
            }
            return this;
        }
        return fail(error);
    }

    public <S1, F1> Result<S1, F1> then(Function<S, Result<S1, F1>> onSuccess, Function<F, Result<S1, F1>> onFail) {
        if (isSuccess()) {
            return onSuccess.apply(value);
        }
        return onFail.apply(error);
    }

    public <S1> Result<S, F> peekThen(Function<S, Result<S1, F>> function) {
        if (isSuccess()) {
            Result<S1, F> result = function.apply(value);
            if (result.isSuccess()) {
                return this;
            } else {
                return Result.fail(result.error);
            }
        }
        return fail(error);
    }

    public <S1> Result<S1, F> map(Function<S, S1> function) {
        if (isSuccess()) {
            return success(function.apply(value));
        }
        return fail(error);
    }

    public static <S, S1, S2, S3, F> Result<S, F> merge(Result<S1, F> result1, Result<S2, F> result2, Result<S3, F> result3, FunctionThree<Result<S, F>, S1, S2, S3> function) {
        if (result1.isSuccess()) {
            if (result2.isSuccess()) {
                if (result3.isSuccess()) {
                    return function.apply(result1.value, result2.value, result3.value);
                }
                return fail(result3.error);
            }
            return fail(result2.error);
        }
        return fail(result1.error);
    }

    public static <S, S1, S2, F> Result<S, F> merge(Result<S1, F> result1, Result<S2, F> result2, FunctionDouble<Result<S, F>, S1, S2> function) {
        if (result1.isSuccess()) {
            if (result2.isSuccess()) {
                return function.apply(result1.value, result2.value);
            }
            return fail(result2.error);
        }
        return fail(result1.error);
    }

    public static <S> Result<S, IFailAggregate> checkScope(ScopeType scopeType, RoleService roleService, Supplier<Result<S, IFailAggregate>> supplier) {
        return Role.FindById.of(UserContextHolder.getCurrentUser().getRoleId())
                .execute(roleService)
                .isTrue(roleAggregate -> roleAggregate.roleHasScope(scopeType),
                        onFail -> ResultAggregate.Fails.Default.of(FailEvent.PERMISSION_DENIED.fail(scopeType.getDescription())))
                .then(r -> supplier.get());
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

    public Result<S, F> onError(Function<F, Result<S, F>> onFail) {
        if (!isSuccess()) {
            return onFail.apply(error);
        }
        return this;
    }

    public Result<S, F> rollbackIfError() {
        if (!isSuccess()) {
            try {
                log.debug("Rollback if error");
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            } catch (Exception e) {
                //
            }
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

    @FunctionalInterface
    public interface FunctionDouble<R, A, B> {
        R apply(A a, B b);
    }

    @FunctionalInterface
    public interface FunctionThree<R, A, B, C> {
        R apply(A a, B b, C c);
    }
}
