package ru.dda.homecrmback.domain.subdomain.employee.dto;

public record RegistrationEmployeeDTO(
        String name,
        String phone,
        String password,
        long roleId) {
}
