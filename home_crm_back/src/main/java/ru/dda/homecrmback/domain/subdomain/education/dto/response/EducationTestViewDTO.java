package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;

import java.util.List;

@Builder
public record EducationTestViewDTO(
        EducationTestDTO test,
        EducationTestEmployeesDTO testEmployees,
        EducationTestSessionsDTO testSessions,
        List<EducationTestResultDTO> testResults
) {
}
