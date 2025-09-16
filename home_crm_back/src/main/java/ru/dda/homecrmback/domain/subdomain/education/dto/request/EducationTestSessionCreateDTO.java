package ru.dda.homecrmback.domain.subdomain.education.dto.request;

public record EducationTestSessionCreateDTO(
        long testId,
        long employeeId
) {
}
