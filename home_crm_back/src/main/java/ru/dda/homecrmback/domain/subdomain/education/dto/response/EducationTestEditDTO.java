package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

@Builder
public record EducationTestEditDTO(
        EducationTestDTO test,
        EducationTestQuestionsDTO testQuestions
) {
}
