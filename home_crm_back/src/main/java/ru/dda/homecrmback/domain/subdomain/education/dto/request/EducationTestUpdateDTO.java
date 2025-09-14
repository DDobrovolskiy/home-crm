package ru.dda.homecrmback.domain.subdomain.education.dto.request;

public record EducationTestUpdateDTO(
        long id,
        String name,
        int timeLimitMinutes
) {
}
