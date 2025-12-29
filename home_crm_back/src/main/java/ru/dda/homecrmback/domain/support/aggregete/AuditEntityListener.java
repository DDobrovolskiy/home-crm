package ru.dda.homecrmback.domain.support.aggregete;

import jakarta.persistence.PostPersist;
import jakarta.persistence.PostRemove;
import jakarta.persistence.PostUpdate;

public class AuditEntityListener {
    @PostPersist
    @PostUpdate
    @PostRemove
    public void onAnyChange(Object entity) {
        if (entity instanceof BaseAuditableEntity auditable) {
            TransactionEventBuffer buffer = BeanUtil.getBean(TransactionEventBuffer.class);
            buffer.addEvent(
                    auditable.getEntityName(),
                    auditable.getId(),
                    auditable.getOrganization().getId()
            );

            // Регистрируем отправку в конце транзакции
            TransactionEventPublisher.registerSynchronization();
        }
    }
}
