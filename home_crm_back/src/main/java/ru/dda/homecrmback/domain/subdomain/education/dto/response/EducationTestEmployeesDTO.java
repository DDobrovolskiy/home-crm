package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;

import java.util.List;

@Builder
public record EducationTestEmployeesDTO(
        List<EmployeeDTO> employees
) {
}
