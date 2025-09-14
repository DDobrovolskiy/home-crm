package ru.dda.homecrmback.domain.subdomain.education.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationDTO;

@Builder
public record EducationTestDTO(
        long id,
        String name,
        boolean ready,
        int timeLimitMinutes,
        OrganizationDTO organization
) {
}
