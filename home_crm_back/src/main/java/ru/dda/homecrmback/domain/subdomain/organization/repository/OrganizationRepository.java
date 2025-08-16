package ru.dda.homecrmback.domain.subdomain.organization.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;

import java.util.Collection;
import java.util.List;

@Repository
public interface OrganizationRepository extends CrudRepository<OrganizationAggregate, Long> {
    List<OrganizationAggregate> findAllByOwnerId(Long ownerId);

    List<OrganizationAggregate> findAllByIdIn(Collection<Long> ids);
}
