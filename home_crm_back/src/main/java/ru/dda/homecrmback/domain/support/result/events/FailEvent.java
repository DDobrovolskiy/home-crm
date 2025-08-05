package ru.dda.homecrmback.domain.support.result.events;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import ru.dda.homecrmback.domain.support.result.dto.Fail;

@Getter
@RequiredArgsConstructor
public enum FailEvent {
    ERROR_ON_SAVE("%s"),
    IS_EXISTS("%s eже существует"),
    VALIDATION("%s"),
    WRONG_PASSWORD("Неправильный логин или пароль"),
    NOT_FOUND("Не найден: %s");

    private final String pattern;

    public Fail arg(Object... arg) {
        return new Fail(this, this.pattern.formatted(arg));
    }
}
