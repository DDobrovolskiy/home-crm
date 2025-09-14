package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

@Builder
public record EducationOptionDTO(
        long id,
        String text,
        boolean correct,
        EducationQuestionDTO question
) {
}
