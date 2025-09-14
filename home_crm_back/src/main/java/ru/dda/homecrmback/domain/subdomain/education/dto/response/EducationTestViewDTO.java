package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

@Builder
public record EducationTestViewDTO(
        EducationTestDTO test,
        EducationTestEmployeesDTO testEmployees,
        EducationTestSessionsDTO testSessions
) {
}
