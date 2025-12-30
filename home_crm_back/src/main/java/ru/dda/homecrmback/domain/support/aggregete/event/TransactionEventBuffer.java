package ru.dda.homecrmback.domain.support.aggregete.event;

import lombok.Getter;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.RequestScope;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Getter
@Component
@RequestScope
public class TransactionEventBuffer {
    private final Map<String, Set<Long>> buffer = new HashMap<>();
    private Long organizationId;

    public void addEvent(String entityName, Long id, Long orgId) {
        this.organizationId = orgId;
        buffer.computeIfAbsent(entityName, k -> new HashSet<>()).add(id);
    }
}
