package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeTestViewDTO;

import java.util.List;

@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrganizationEmployeesTestsDTO(
        List<EmployeeTestViewDTO> employees
) {
}
