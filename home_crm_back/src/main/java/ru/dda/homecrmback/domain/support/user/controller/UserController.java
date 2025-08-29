package ru.dda.homecrmback.domain.support.user.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;
import ru.dda.homecrmback.domain.support.user.UserService;
import ru.dda.homecrmback.domain.support.user.dto.response.UserDTO;
import ru.dda.homecrmback.domain.support.user.dto.response.UserEmployeesDTO;
import ru.dda.homecrmback.domain.support.user.dto.response.UserOrganizationsDTO;

@RestController
@RequestMapping(UserController.PATH)
@RequiredArgsConstructor
public class UserController {
    public static final String PATH = "/user";

    private final UserService userService;

    @GetMapping
    public IResponse<UserDTO> getUser() {
        return userService.getUser()
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/organization")
    public IResponse<UserOrganizationsDTO> getUserOrganization() {
        return userService.getUserOrganization()
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/employee")
    public IResponse<UserEmployeesDTO> getUserEmployee() {
        return userService.getUserEmployee()
                .response(ResultAggregate::getErrorData);
    }
}
