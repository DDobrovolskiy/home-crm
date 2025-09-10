package ru.dda.homecrmback.domain.subdomain.role.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.role.Role;
import ru.dda.homecrmback.domain.subdomain.role.RoleService;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.subdomain.role.dto.request.RoleCreateDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.request.RoleDeleteDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.request.RoleUpdateDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleDTO;
import ru.dda.homecrmback.domain.subdomain.role.dto.response.RoleScopesDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(RoleController.PATH)
@RequiredArgsConstructor
public class RoleController {
    public static final String PATH = "/role";

    private final RoleService roleService;

    @GetMapping()
    private IResponse<RoleDTO> current() {
        return Role.Current.of()
                .execute(roleService::getCurrent)
                .map(RoleAggregate::getRoleDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping(path = "/{id}")
    private IResponse<RoleDTO> get(@PathVariable Long id) {
        return Role.Find.of(id)
                .execute(roleService::find)
                .map(RoleAggregate::getRoleDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping
    private IResponse<RoleDTO> create(@RequestBody RoleCreateDTO dto) {
        return Role.Create.of(dto.name(), dto.description(), dto.scopes())
                .execute(roleService::create)
                .map(RoleAggregate::getRoleDTO)
                .response(ResultAggregate::getErrorData);
    }


    @PutMapping
    public IResponse<RoleDTO> update(@RequestBody RoleUpdateDTO dto) {
        return Role.Update.of(dto.id(), dto.name(), dto.description(), dto.scopes())
                .execute(roleService::update)
                .map(RoleAggregate::getRoleDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping
    public IResponse<Integer> delete(@RequestBody RoleDeleteDTO dto) {
        return Role.Delete.of(dto.id())
                .execute(roleService::delete)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/scopes")
    private IResponse<RoleScopesDTO> currentScope() {
        return Role.Current.of()
                .execute(roleService::getCurrent)
                .map(RoleAggregate::getRoleScopesDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping(path = "/{id}/scopes")
    private IResponse<RoleScopesDTO> getScope(@PathVariable Long id) {
        return Role.Find.of(id)
                .execute(roleService::find)
                .map(RoleAggregate::getRoleScopesDTO)
                .response(ResultAggregate::getErrorData);
    }
}
