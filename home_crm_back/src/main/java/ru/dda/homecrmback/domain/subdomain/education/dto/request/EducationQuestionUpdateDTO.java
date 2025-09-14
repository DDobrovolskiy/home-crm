package ru.dda.homecrmback.domain.subdomain.education.dto.request;

public record EducationQuestionUpdateDTO(
        long id,
        String text,
        long testId
) {
}
