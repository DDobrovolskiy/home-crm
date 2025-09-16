package ru.dda.homecrmback.domain.subdomain.education.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestResultAggregate;

@Repository
public interface TestResultRepository extends CrudRepository<TestResultAggregate, Long> {

}
