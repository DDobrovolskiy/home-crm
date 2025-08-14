package ru.dda.homecrmback.domain.subdomain.organization.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;

@Repository
public interface OrganizationRepository extends CrudRepository<OrganizationAggregate, Long> {
}
