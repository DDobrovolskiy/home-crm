package ru.dda.homecrmback.domain.support.result.events;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import ru.dda.homecrmback.domain.support.result.dto.Fail;

@Getter
@RequiredArgsConstructor
public enum FailEvent {
    ERROR_ON_SAVE("%s"),
    USER_IS_EXISTS("Пользователь eже существует"),
    USER_NOT_FOUND("Пользователь не найден"),
    ROLE_NOT_FOUND("Роль не найдена"),
    ORGANIZATION_NOT_FOUND("Организация не найдена"),
    EMPLOYEE_IS_EXIST("Данный сотрудник уже есть в организации"),
    EMPLOYEE_NOT_FOUND("Сотрудник не найден"),
    TEST_NOT_FOUND("Тест не найден"),
    VALIDATION("%s"),
    WRONG_PASSWORD("Неправильный логин или пароль"),
    WRONG_HEADER("Неправильный значение в заголовке"),
    PERMISSION_DENIED("Нет разрешения: %s"),
    ROLE_HAS_EMPLOYEE("Для удаления роли: %s необходимо отвязать всех сотрудников"),
    NOT_FOUND("Не найден: %s");

    private final String pattern;

    public Fail fail(Object... arg) {
        return new Fail(this, this.pattern.formatted(arg));
    }
}
