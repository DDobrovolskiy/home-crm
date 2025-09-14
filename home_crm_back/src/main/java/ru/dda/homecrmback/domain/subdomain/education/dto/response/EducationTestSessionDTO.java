package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;

import java.time.LocalDateTime;

@Builder
public record EducationTestSessionDTO(
        long id,
        LocalDateTime startTime,
        LocalDateTime endTime,
        EmployeeDTO employee,
        EducationTestDTO test
) {
}
