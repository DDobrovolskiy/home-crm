package ru.dda.homecrmback.domain.support.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

    @Transactional(readOnly = true)
    public Result<UserAggregate, IFailAggregate> getUserAggregateById(User.FindById command) {
        return userRepository.findById(command.id())
                .map(Result::<UserAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.USER_NOT_FOUND.fail())));
    }

    @Transactional(readOnly = true)
    public Result<UserAggregate, IFailAggregate> getUserAggregateById(long id) {
        return userRepository.findById(id)
                .map(Result::<UserAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.USER_NOT_FOUND.fail())));
    }

    @Transactional(readOnly = true)
    public Result<UserAggregate, IFailAggregate> getUserAggregateByToken(String token) {
        return userRepository.findByToken(token)
                .map(Result::<UserAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.USER_NOT_FOUND.fail())));
    }

    @Transactional(readOnly = true)
    public Result<UserAggregate, IFailAggregate> getUserAggregateByPhone(String phone) {
        return userRepository.findByPhone(phone)
                .map(Result::<UserAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.USER_NOT_FOUND.fail())));
    }

    @Transactional
    public Result<UserAggregate, IFailAggregate> registration(User.Registration command) {
        return getUserAggregateByPhone(command.phone())
                .then(ifExists ->
                                Result.fail(ResultAggregate.Fails.Default.of(FailEvent.USER_IS_EXISTS.fail())),
                        ifNotExists -> UserAggregate.create(command.name(), command.phone(), command.password()))
                .then(userAggregate -> {
                    try {
                        return Result.success(userRepository.save(userAggregate));
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения пользователя")));
                    }
                });
    }

    @Transactional
    public Result<UserAggregate, IFailAggregate> registrationOrGet(User.RegistrationOrGet command) {
        return getUserAggregateByPhone(command.user().phone())
                .onError(ifNotExists ->
                        command.user().execute(this)
                                .then(this::save)
                );
    }

    @Transactional
    public Result<UserAggregate, IFailAggregate> save(UserAggregate userAggregate) {
        try {
            return Result.success(userRepository.save(userAggregate));
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return Result.fail(ResultAggregate.Fails.Default.of(
                    FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения пользователя")));
        }
    }

    @Transactional(readOnly = true)
    public Result<String, IFailAggregate> login(SimpleLoginDTO dto) {
        return getUserAggregateByPhone(dto.phone())
                .then(userAggregate -> userAggregate.login(dto));
    }

    @Transactional
    public Result<Boolean, IFailAggregate> logout(String token) {
        return getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }

    @Transactional(readOnly = true)
    public Result<Boolean, IFailAggregate> check(String token) {
        return getUserAggregateByToken(token)
                .map(UserAggregate::logout);
    }

}
