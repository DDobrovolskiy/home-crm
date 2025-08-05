package ru.dda.homecrmback.domain.support.result.dto;

import ru.dda.homecrmback.domain.support.result.events.FailEvent;

public record Fail(
        FailEvent event,
        String message
) {
}
