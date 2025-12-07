package ru.dda.homecrmback.domain.subdomain.organization.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.organization.OrganizationService;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.dto.request.OrganizationCreateDTO;
import ru.dda.homecrmback.domain.subdomain.organization.dto.request.OrganizationDeleteDTO;
import ru.dda.homecrmback.domain.subdomain.organization.dto.request.OrganizationUpdateDTO;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.*;
import ru.dda.homecrmback.domain.subdomain.role.Role;
import ru.dda.homecrmback.domain.subdomain.role.RoleService;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(OrganizationController.PATH)
@RequiredArgsConstructor
public class OrganizationController {
    public static final String PATH = "/organization";

    private final OrganizationService organizationService;
    private final RoleService roleService;

    @GetMapping
    public IResponse<OrganizationSelectedDTO> getOrganization() {
        return Result.merge(
                Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId())
                        .execute(organizationService::findById)
                        .map(OrganizationAggregate::organizationDTO),
                Role.Current.of()
                        .execute(roleService::getCurrent)
                        .map(RoleAggregate::getRoleDTO),
                (organization, role) -> {
                    return Result.success(OrganizationSelectedDTO.builder()
                            .organization(organization)
                            .role(role)
                            .build());
                }
        ).response(ResultAggregate::getErrorData);
    }

    @PostMapping
    public IResponse<OrganizationDTO> createOrganization(@RequestBody OrganizationCreateDTO dto) {
        return Organization.Create.of(dto.name(), UserContextHolder.getCurrentUser().getUserId())
                .execute(organizationService::create)
                .map(OrganizationAggregate::organizationDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PutMapping
    public IResponse<OrganizationDTO> updateOrganization(@RequestBody OrganizationUpdateDTO dto) {
        return Organization.Update.of(dto.id(), dto.name(), UserContextHolder.getCurrentUser().getUserId())
                .execute(organizationService::update)
                .map(OrganizationAggregate::organizationDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping
    public IResponse<Integer> deleteOrganization(@RequestBody OrganizationDeleteDTO dto) {
        return Organization.Delete.of(dto.id(), UserContextHolder.getCurrentUser().getUserId())
                .execute(organizationService::delete)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/employee")
    public IResponse<OrganizationEmployeesDTO> getOrganizationEmployee() {
        return Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId())
                .execute(organizationService::findById)
                .map(OrganizationAggregate::organizationEmployeesDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/employee/test")
    public IResponse<OrganizationEmployeesTestsDTO> getOrganizationEmployeeTest() {
        return Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId())
                .execute(organizationService::findById)
                .map(OrganizationAggregate::getOrganizationEmployeesTestsDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/role")
    public IResponse<OrganizationRolesDTO> getOrganizationRole() {
        return Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId())
                .execute(organizationService::findById)
                .map(OrganizationAggregate::organizationRolesDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/tests")
    public IResponse<OrganizationTestsDTO> getOrganizationTest() {
        return Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId())
                .execute(organizationService::findById)
                .map(OrganizationAggregate::getOrganizationTestsDTO)
                .response(ResultAggregate::getErrorData);
    }
}
