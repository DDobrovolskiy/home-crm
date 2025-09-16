package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

@Builder
public record EducationTestResultDetailDTO(
        long id,
        String questionText,
        boolean isCorrect
) {
}
