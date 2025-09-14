package ru.dda.homecrmback.domain.subdomain.education.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.QuestionAggregate;

import java.util.Optional;

@Repository
public interface QuestionRepository extends CrudRepository<QuestionAggregate, Long> {
    Optional<QuestionAggregate> findByIdAndTestIdAndOrganizationId(Long id, Long testId, Long organizationId);
}
