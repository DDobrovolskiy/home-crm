package ru.dda.homecrmback.domain.subdomain.education.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestSessionAggregate;

import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface TestSessionRepository extends CrudRepository<TestSessionAggregate, Long> {
    Optional<TestSessionAggregate> findByOrganizationIdAndEmployeeIdAndTestId(Long organizationId, Long employeeId, Long testId);

    Optional<TestSessionAggregate> findByOrganizationIdAndEmployeeIdAndTestIdAndEndTimeAfterAndResultIsNull(Long organizationId, Long employeeId, Long testId, LocalDateTime endTime);

    Optional<TestSessionAggregate> findByOrganizationIdAndEmployeeIdAndTestIdAndEndTimeIsNullAndResultIsNull(Long organizationId, Long employeeId, Long testId);

}
