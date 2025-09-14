package ru.dda.homecrmback.domain.subdomain.education.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;

import java.util.Optional;

@Repository
public interface TestRepository extends CrudRepository<TestAggregate, Long> {
    Optional<TestAggregate> findByIdAndOrganizationId(Long id, Long organizationId);
}
