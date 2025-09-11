package ru.dda.homecrmback.domain.subdomain.scope.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.dda.homecrmback.domain.subdomain.scope.aggregate.ScopeAggregate;

import java.util.Collection;
import java.util.Set;

@Repository
public interface ScopeRepository extends CrudRepository<ScopeAggregate, Long> {
    Set<ScopeAggregate> findAllByIdIn(Collection<Long> ids);

    Set<ScopeAggregate> findAll();
}
