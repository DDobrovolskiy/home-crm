package ru.dda.homecrmback.domain.support.user.dto.response;

import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationInfoDTO;

import java.util.List;

@Builder
public record UserOrganizationDTO(
        List<OrganizationInfoDTO> ownerOrganizations,
        List<EmployeeDTO> employeeOrganizations
) {
}
