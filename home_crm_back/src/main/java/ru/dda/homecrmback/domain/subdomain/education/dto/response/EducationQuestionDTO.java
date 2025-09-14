package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

@Builder
public record EducationQuestionDTO(
        long id,
        String text,
        EducationTestDTO test
) {
}
