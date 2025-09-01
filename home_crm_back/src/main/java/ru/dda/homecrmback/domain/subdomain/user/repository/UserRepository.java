package ru.dda.homecrmback.domain.subdomain.user.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.user.aggregate.UserAggregate;

import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<UserAggregate, Long> {
    Optional<UserAggregate> findByPhone(String phone);
    Optional<UserAggregate> findByToken(String token);
}
