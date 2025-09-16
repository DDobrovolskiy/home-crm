package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestSessionDTO;

import java.util.List;


@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record EmployeeSessionDTO(
        List<EducationTestSessionDTO> sessions
) {
}
