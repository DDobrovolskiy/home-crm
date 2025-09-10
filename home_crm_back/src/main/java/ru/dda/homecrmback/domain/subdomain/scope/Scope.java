package ru.dda.homecrmback.domain.subdomain.scope;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;

import java.util.Set;

public interface Scope {

    @Builder
    record Find(
            Set<Long> scopeIds
    ) implements IExecute<Find> {
        public static Find of(Set<Long> scopeIds) {
            return new Find(scopeIds);
        }
    }
}
