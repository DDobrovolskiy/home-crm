package ru.dda.homecrmback.domain.subdomain.education.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.OptionAggregate;

import java.util.Optional;

@Repository
public interface OptionRepository extends CrudRepository<OptionAggregate, Long> {
    Optional<OptionAggregate> findByIdAndQuestionIdAndOrganizationId(Long id, Long questionId, Long organizationId);
}
