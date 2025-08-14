package ru.dda.homecrmback.domain.support.role.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;

import java.util.Optional;

@Repository
public interface RoleRepository extends CrudRepository<RoleAggregate, Long> {
    Optional<RoleAggregate> findByIdAndOrganizationId(Long id, Long organizationId);

    Optional<RoleAggregate> findByNameAndOrganizationId(String name, Long organizationId);
}
