package ru.dda.homecrmback.domain.subdomain.employee.dto;

public record EmployeeCreateDTO(
        String name,
        String phone,
        String password,
        long roleId) {
}
