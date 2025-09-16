package ru.dda.homecrmback.domain.support.result.validator;

import lombok.Getter;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.dto.Fail;

import java.util.LinkedList;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Supplier;

@Getter
public class Validator {
    private final List<Fail> fails = new LinkedList<>();

    public static Validator create() {
        return new Validator();
    }

    public Validator is(boolean value, Do log, Fail fail) {
        if (!value) {
            log.run();
            fails.add(fail);
        }
        return this;
    }

    public Validator is(boolean value, Do log, Fail fail, Consumer<Validator> next) {
        if (!value) {
            log.run();
            fails.add(fail);
        } else {
            next.accept(this);
        }
        return this;
    }

    public <T> Result<T, IFailAggregate> getResult(Supplier<T> factory) {
        if (fails.isEmpty()) {
            return Result.success(factory.get());
        }
        return Result.fail(ResultAggregate.Fails.Default.of(fails));
    }

    public <T> Result<T, IFailAggregate> then(Supplier<Result<T, IFailAggregate>> factory) {
        return factory.get();
    }

    @FunctionalInterface
    public interface Do {
        void run();
    }
}
