package ru.dda.homecrmback.domain.subdomain.role.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.scope.dto.ScopeDTO;

import java.util.List;

@Builder
public record RoleDTO(
        long id,
        String name,
        String description,
        boolean owner,
        List<ScopeDTO> scopes
) {
}
