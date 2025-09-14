package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestViewDTO;

import java.util.List;

@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrganizationTestsDTO(
        List<EducationTestViewDTO> tests
) {
}
