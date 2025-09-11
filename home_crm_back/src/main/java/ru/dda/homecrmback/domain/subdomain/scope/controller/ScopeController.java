package ru.dda.homecrmback.domain.subdomain.scope.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.dda.homecrmback.domain.subdomain.scope.ScopeService;
import ru.dda.homecrmback.domain.subdomain.scope.aggregate.ScopeAggregate;
import ru.dda.homecrmback.domain.subdomain.scope.dto.ScopeDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

import java.util.List;

@RestController
@RequestMapping(ScopeController.PATH)
@RequiredArgsConstructor
public class ScopeController {
    public static final String PATH = "/scope";

    private final ScopeService scopeService;

    @GetMapping()
    private IResponse<List<ScopeDTO>> all() {
        return scopeService.findAll()
                .map(items -> items.stream().map(ScopeAggregate::getScopeDTO).toList())
                .response(ResultAggregate::getErrorData);
    }

}
