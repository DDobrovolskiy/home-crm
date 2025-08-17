package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;

@Builder
public record OrganizationInfoDTO(
        Long id,
        String name,
        UserAggregate.DTO.UserBaseDTO owner
) {
}
