package ru.dda.homecrmback.domain.support.user.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.support.user.aggregate.UserRoleAggregate;

import java.util.Optional;

@Repository
public interface UserRoleRepository extends CrudRepository<UserRoleAggregate, Long> {
    Optional<UserRoleAggregate> findByUserIdAndOrganizationId(long userId, long organizationId);
}
