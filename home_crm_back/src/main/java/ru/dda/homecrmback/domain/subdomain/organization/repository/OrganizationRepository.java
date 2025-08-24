package ru.dda.homecrmback.domain.subdomain.organization.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrganizationRepository extends CrudRepository<OrganizationAggregate, Long> {
    List<OrganizationAggregate> findAllByOwnerId(Long ownerId);
    List<OrganizationAggregate> findAllByIdIn(Collection<Long> ids);
    int deleteByIdAndOwnerId(Long id, Long ownerId);

    Optional<OrganizationAggregate> findByIdAndOwnerId(Long id, Long ownerId);
}
