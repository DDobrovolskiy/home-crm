package ru.dda.homecrmback.domain.subdomain.role.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;

import java.util.Optional;

@Repository
public interface RoleRepository extends CrudRepository<RoleAggregate, Long> {
    Optional<RoleAggregate> findByIdAndOrganizationId(Long id, Long organizationId);

    int deleteByIdAndOrganizationId(Long id, Long organizationId);
}
