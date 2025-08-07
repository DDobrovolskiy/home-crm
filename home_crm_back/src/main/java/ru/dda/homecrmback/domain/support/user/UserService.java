package ru.dda.homecrmback.domain.support.user;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleAuthDTO;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;
import ru.dda.homecrmback.domain.support.user.repository.UserRepository;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    @Transactional()
    public Result<UserAggregate, IFailAggregate> getUserAggregateByToken(String token) {
        return userRepository.findByToken(token)
                .map(Result::<UserAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.NOT_FOUND.arg("Пользователь"))));
    }

    @Transactional()
    public Result<UserAggregate, IFailAggregate> getUserAggregateByPhone(String phone) {
        return userRepository.findByPhone(phone)
                .map(Result::<UserAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.NOT_FOUND.arg("Пользователь"))));
    }

    @Transactional
    public Result<String, IFailAggregate> registration(SimpleAuthDTO dto) {
        return getUserAggregateByPhone(dto.phone())
                .then(ifExists ->
                                Result.fail(ResultAggregate.Fails.Default.of(FailEvent.IS_EXISTS.arg("Пользователь"))),
                        ifNotExists -> UserAggregate.create(dto))
                .then(userAggregate -> {
                    try {
                        return Result.success(userRepository.save(userAggregate));
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.arg("Ошибка сохранения пользователя")));
                    }
                })
                .map(UserAggregate::getToken);
    }

    @Transactional
    public Result<String, IFailAggregate> login(SimpleLoginDTO dto) {
        return getUserAggregateByPhone(dto.phone())
                .then(userAggregate -> userAggregate.login(dto));
    }

    @Transactional
    public Result<Boolean, IFailAggregate> logout(String token) {
        return getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }

    @Transactional
    public Result<Boolean, IFailAggregate> check(String token) {
        return getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }
}
