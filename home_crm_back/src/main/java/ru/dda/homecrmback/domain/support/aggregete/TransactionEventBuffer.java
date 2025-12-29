package ru.dda.homecrmback.domain.support.aggregete;

import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.RequestScope;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Component
@RequestScope
public class TransactionEventBuffer {
    // Карта: НазваниеСущности -> Набор ID
    private final Map<String, Set<Long>> buffer = new HashMap<>();
    private Long organizationId;

    public void addEvent(String entityName, Long id, Long orgId) {
        this.organizationId = orgId;
        buffer.computeIfAbsent(entityName, k -> new HashSet<>()).add(id);
    }

    public Map<String, Set<Long>> getBuffer() {
        return buffer;
    }

    public Long getOrganizationId() {
        return organizationId;
    }
}
