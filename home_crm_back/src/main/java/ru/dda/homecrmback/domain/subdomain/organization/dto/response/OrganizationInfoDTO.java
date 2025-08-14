package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.support.user.dto.response.UserDTO;

@Builder
public record OrganizationInfoDTO(
        Long id,
        String name,
        UserDTO owner
) {
}
