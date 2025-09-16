package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;


@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record EmployeeTestViewDTO(
        EmployeeDTO employee,
        EmployeeTestsDTO employeeTests
) {
}
