package ru.dda.homecrmback.domain.subdomain.role.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;

import java.util.List;

@Builder
public record RoleEmployeeDTO(
        List<EmployeeDTO> employees
) {
}
