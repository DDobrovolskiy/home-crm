package ru.dda.homecrmback.domain.subdomain.employee.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestDTO;

import java.util.List;


@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record EmployeeTestsDTO(
        List<EducationTestDTO> tests
) {
}
