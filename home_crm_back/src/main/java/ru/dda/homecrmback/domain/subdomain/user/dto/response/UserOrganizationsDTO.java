package ru.dda.homecrmback.domain.subdomain.user.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationDTO;

import java.util.List;

@Builder
public record UserOrganizationsDTO(
        List<OrganizationDTO> organizations
) {
}
