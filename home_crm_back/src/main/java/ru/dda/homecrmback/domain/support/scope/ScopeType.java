package ru.dda.homecrmback.domain.support.scope;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ScopeType {
    ORGANIZATION_UPDATE("Изменение организации"),
    TEST_CREATE("Создание тестов");

    private final String description;
}
