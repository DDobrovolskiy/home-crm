package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserDTO;

@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrganizationDTO(
        Long id,
        String name,
        UserDTO owner
) {
}
