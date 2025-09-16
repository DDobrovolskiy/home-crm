package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;

@Builder
public record EducationTestResultDTO(
        long id,
        EducationTestDTO test,
        LocalDateTime completedAt,
        EducationTestSessionDTO session,
        List<EducationTestResultDetailDTO> details
) {
}
