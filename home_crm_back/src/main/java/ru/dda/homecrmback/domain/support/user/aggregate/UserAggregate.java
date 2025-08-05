package ru.dda.homecrmback.domain.support.user.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleAuthDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;
import ru.dda.homecrmback.domain.support.user.context.UserInfo;

import java.util.Objects;
import java.util.UUID;

@Slf4j
@Getter
@Entity
@Table(name = "users")
public class UserAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String token = UUID.randomUUID().toString();
    @NotNull
    private String phone;
    @NotNull
    private String password;

    public Result<String, IFailAggregate> login(SimpleAuthDTO dto) {
        if (Objects.equals(password, dto.password())) {
            return Result.success(token);
        }
        return Result.fail(ResultAggregate.Fails.Default.of(FailEvent.WRONG_PASSWORD.arg()));
    }

    public boolean logout() {
        token = UUID.randomUUID().toString();
        return true;
    }

    public UserInfo getUserInfo() {
        return UserInfo.builder()
                .id(id)
                .build();
    }

    public static Result<UserAggregate, IFailAggregate> create(SimpleAuthDTO dto) {
        return Validator.create()
                .is(dto != null,
                        () -> log.debug("SimpleAuthDTO dto is null"),
                        FailEvent.VALIDATION.arg("Переданный объект пустой"),
                        next -> next
                                .is(dto.password() != null,
                                        () -> log.debug("SimpleAuthDTO#password is null"),
                                        FailEvent.VALIDATION.arg("Пароль не заполнен"))
                                .is(dto.phone() != null,
                                        () -> log.debug("SimpleAuthDTO#phone is null"),
                                        FailEvent.VALIDATION.arg("Номер телефона не заполнен")))
                .getResult(() -> {
                    UserAggregate aggregate = new UserAggregate();
                    aggregate.phone = dto.phone();
                    aggregate.password = dto.password();
                    return aggregate;
                });
    }
}
