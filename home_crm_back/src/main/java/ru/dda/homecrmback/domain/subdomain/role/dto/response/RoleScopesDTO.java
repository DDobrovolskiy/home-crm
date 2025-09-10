package ru.dda.homecrmback.domain.subdomain.role.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.scope.dto.ScopeDTO;

import java.util.List;

@Builder
public record RoleScopesDTO(
        List<ScopeDTO> scopes
) {
}
