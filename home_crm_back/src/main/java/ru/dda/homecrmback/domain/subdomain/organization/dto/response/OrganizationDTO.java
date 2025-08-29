package ru.dda.homecrmback.domain.subdomain.organization.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Builder;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.support.role.dto.response.RoleDTO;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.support.user.dto.response.UserDTO;

import java.util.List;

@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public record OrganizationDTO(
        Long id,
        String name,
        UserDTO owner
) {
}
