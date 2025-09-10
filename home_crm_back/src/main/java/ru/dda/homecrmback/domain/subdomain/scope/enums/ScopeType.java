package ru.dda.homecrmback.domain.subdomain.scope.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ScopeType {
    ORGANIZATION_UPDATE("Изменение организации"),
    TEST_CREATE("Создание тестов");

    private final String description;
}
