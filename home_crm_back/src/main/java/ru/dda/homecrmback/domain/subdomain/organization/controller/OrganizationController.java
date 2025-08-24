package ru.dda.homecrmback.domain.subdomain.organization.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.organization.OrganizationService;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.dto.request.OrganizationCreateDTO;
import ru.dda.homecrmback.domain.subdomain.organization.dto.request.OrganizationDeleteDTO;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;
import ru.dda.homecrmback.domain.support.user.context.UserContextHolder;

@RestController
@RequestMapping(OrganizationController.PATH)
@RequiredArgsConstructor
public class OrganizationController {
    public static final String PATH = "/organization";

    private final OrganizationService organizationService;

    @PostMapping
    public IResponse<OrganizationDTO> createOrganization(@RequestBody OrganizationCreateDTO dto) {
        return Organization.Create.of(dto.name(), UserContextHolder.getCurrentUser().getUserId())
                .execute(organizationService::create)
                .map(OrganizationAggregate::organizationInfoDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping
    public IResponse<Integer> deleteOrganization(@RequestBody OrganizationDeleteDTO dto) {
        return Organization.Delete.of(dto.id(), UserContextHolder.getCurrentUser().getUserId())
                .execute(organizationService::delete)
                .response(ResultAggregate::getErrorData);
    }

}
