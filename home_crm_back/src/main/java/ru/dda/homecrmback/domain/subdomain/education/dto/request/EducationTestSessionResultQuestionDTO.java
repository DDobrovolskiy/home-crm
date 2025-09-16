package ru.dda.homecrmback.domain.subdomain.education.dto.request;

import java.util.Set;

public record EducationTestSessionResultQuestionDTO(
        long questionId,
        Set<Long> options
) {
}
