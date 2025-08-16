package ru.dda.homecrmback.domain.support.user.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;
import ru.dda.homecrmback.domain.support.user.UserService;
import ru.dda.homecrmback.domain.support.user.dto.response.UserOrganizationDTO;

@RestController
@RequestMapping(UserController.PATH)
@RequiredArgsConstructor
public class UserController {
    public static final String PATH = "/user";

    private final UserService userService;

    @GetMapping("/organizations")
    public IResponse<UserOrganizationDTO> getEmployeeOrganization() {
        return userService.getUserOrganization()
                .response(ResultAggregate::getErrorData);
    }
}
