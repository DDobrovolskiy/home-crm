package ru.dda.homecrmback.domain.support.user.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;

import java.util.List;

@Builder
public record UserEmployeesDTO(
        List<EmployeeDTO> employees
) {
}
