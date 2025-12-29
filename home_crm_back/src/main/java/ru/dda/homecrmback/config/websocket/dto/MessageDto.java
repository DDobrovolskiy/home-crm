package ru.dda.homecrmback.config.websocket.dto;

import lombok.Builder;

import java.util.Set;

@Builder
public record MessageDto(
        String name,
        Set<Long> ids
) {
}
