package ru.dda.homecrmback.domain.subdomain.education.dto.request;

public record EducationOptionUpdateDTO(
        long id,
        long questionId,
        String text,
        boolean correct
) {
}
