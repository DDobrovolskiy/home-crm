package ru.dda.homecrmback.domain.subdomain.education.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestResultDetailAggregate;

@Repository
public interface TestResultDetailRepository extends CrudRepository<TestResultDetailAggregate, Long> {

}
