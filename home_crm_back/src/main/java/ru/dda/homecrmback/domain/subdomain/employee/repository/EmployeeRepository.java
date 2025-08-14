package ru.dda.homecrmback.domain.subdomain.employee.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;

import java.util.Optional;

@Repository
public interface EmployeeRepository extends CrudRepository<EmployeeAggregate, Long> {
    Optional<EmployeeAggregate> findByUserIdAndOrganizationId(Long userId, Long organizationId);
}
