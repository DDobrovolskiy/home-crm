package ru.dda.homecrmback.domain.support.user.dto;


public record UserOrganizationDTO(
        long id,
        String name,
        String roleInOrganization
) {
}
