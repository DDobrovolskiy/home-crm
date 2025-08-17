package ru.dda.homecrmback.domain.support.user;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.user.aggregate.UserAggregate;

public interface User {

    @Builder
    record FindByPhone(
            String phone
    ) {

        public static FindByPhone of(String phone) {
            return new FindByPhone(phone);
        }

        public Result<UserAggregate, IFailAggregate> execute(UserDomainService userDomainService) {
            return userDomainService.getUserAggregateByPhone(phone);
        }
    }

    @Builder
    record FindById(
            long id
    ) implements IExecute<FindById> {
        public static FindById of(long userId) {
            return new FindById(userId);
        }
    }

    @Builder
    record Registration(
            String name,
            String phone,
            String password
    ) implements IExecute<Registration> {

        public static Registration of(String name, String phone, String password) {
            return new Registration(name, phone, password);
        }
    }

    @Builder
    record RegistrationOrGet(
            Registration user
    ) implements IExecute<RegistrationOrGet> {
        public static RegistrationOrGet of(String name, String phone, String password) {
            return new RegistrationOrGet(Registration.of(name, phone, password));
        }
    }
}
