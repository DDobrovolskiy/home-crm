package ru.dda.homecrmback.domain.support.auth.controller;


import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleAuthDTO;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;
import ru.dda.homecrmback.domain.support.user.User;
import ru.dda.homecrmback.domain.support.user.UserService;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;

@RestController
@RequestMapping(IAuthController.PATH)
@RequiredArgsConstructor
public class AuthController implements IAuthController {
    private final UserService authService;

    @PostMapping("/registration")
    public IResponse<String> registration(@Valid @RequestBody SimpleAuthDTO dto) {
        return User.Registration.of(dto.name(), dto.phone(), dto.password())
                .execute(authService)
                .map(UserAggregate::getToken)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping("/login")
    public IResponse<String> login(@Valid @RequestBody SimpleLoginDTO dto) {
        return authService.login(dto)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping("/logout")
    public IResponse<Boolean> logout(@RequestHeader("Authorization") String token) {
        return authService.logout(token)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping("/check")
    public Boolean check(@RequestHeader("Authorization") String token) {
        return authService.check(token)
                .complite(s -> true, f -> false);
    }
}
