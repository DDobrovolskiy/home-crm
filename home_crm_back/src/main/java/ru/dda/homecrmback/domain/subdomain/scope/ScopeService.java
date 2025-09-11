package ru.dda.homecrmback.domain.subdomain.scope;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.scope.aggregate.ScopeAggregate;
import ru.dda.homecrmback.domain.subdomain.scope.repository.ScopeRepository;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;

import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class ScopeService {
    private final ScopeRepository scopeRepository;

    @Transactional(readOnly = true)
    public Result<Set<ScopeAggregate>, IFailAggregate> find(Scope.Find command) {
        if (command.scopeIds().isEmpty()) {
            return Result.success(Set.of());
        }
        return Result.success(scopeRepository.findAllByIdIn(command.scopeIds()));
    }

    @Transactional(readOnly = true)
    public Result<Set<ScopeAggregate>, IFailAggregate> findAll() {
        return Result.success(scopeRepository.findAll());
    }
}
