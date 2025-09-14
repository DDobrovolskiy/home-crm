package ru.dda.homecrmback.domain.subdomain.education.dto.request;

public record EducationQuestionCreateDTO(
        String text,
        long testId
) {
}
