package ru.dda.homecrmback.domain.support.aggregete;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum NotifyType {
    EMPLOYEE("Изменение долженности"),
    EMPLOYEE_CHANGED("Изменение в разделе сотрудники");

    private final String description;
}
