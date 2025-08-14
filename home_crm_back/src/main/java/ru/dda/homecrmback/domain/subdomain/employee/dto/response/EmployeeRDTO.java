package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

public record EmployeeRDTO(
        long id,
        long userId,
        long organizationId,
        long roleId
) {
}
