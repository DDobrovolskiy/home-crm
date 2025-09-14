package ru.dda.homecrmback.domain.subdomain.education.dto.request;

public record EducationOptionUpdateDTO(
        long id,
        String text,
        boolean correct
) {
}
