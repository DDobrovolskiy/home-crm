package ru.dda.homecrmback.domain.support.auth.controller;


import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.user.User;
import ru.dda.homecrmback.domain.subdomain.user.UserService;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleAuthDTO;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.auth.dto.response.AuthSuccessDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(IAuthController.PATH)
@RequiredArgsConstructor
public class AuthController implements IAuthController {
    private final UserService authService;

    @PostMapping("/registration")
    public IResponse<AuthSuccessDTO> registration(@Valid @RequestBody SimpleAuthDTO dto) {
        return User.Registration.of(dto.name(), dto.phone(), dto.password())
                .execute(authService::registration)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping("/login")
    public IResponse<AuthSuccessDTO> login(@Valid @RequestBody SimpleLoginDTO dto) {
        return authService.login(dto)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping("/logout")
    public IResponse<Boolean> logout(@RequestHeader("Authorization") String token) {
        return authService.logout(token)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/login/token")
    public IResponse<AuthSuccessDTO> loginWithToken(@RequestHeader("Authorization") String token) {
        return authService.loginWithToken(token)
                .response(ResultAggregate::getErrorData);
    }
}
