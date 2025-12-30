package ru.dda.homecrmback.domain.support.aggregete.listeners;

import jakarta.persistence.PostPersist;
import jakarta.persistence.PostRemove;
import jakarta.persistence.PostUpdate;
import ru.dda.homecrmback.domain.support.aggregete.BeanUtil;
import ru.dda.homecrmback.domain.support.aggregete.entity.IAuditableEntity;
import ru.dda.homecrmback.domain.support.aggregete.entity.INotifyBot;
import ru.dda.homecrmback.domain.support.aggregete.event.TransactionEventBuffer;
import ru.dda.homecrmback.domain.support.aggregete.event.TransactionEventPublisher;
import ru.dda.homecrmback.domain.support.event.Event;

public class EntityListener {
    @PostPersist
    public void onPostPersist(Object entity) { onAnyChange(entity, EventType.CREATED); }

    @PostUpdate
    public void onPostUpdate(Object entity) { onAnyChange(entity, EventType.UPDATED); }

    @PostRemove
    public void onPostRemove(Object entity) { onAnyChange(entity, EventType.DELETED); }

    public void onAnyChange(Object entity, EventType action) {
        if (entity instanceof IAuditableEntity auditable) {
            TransactionEventBuffer buffer = BeanUtil.getBean(TransactionEventBuffer.class);
            buffer.addEvent(
                    auditable.getEntityName(),
                    auditable.getId(),
                    auditable.getOrganization().getId()
            );
            // Регистрируем отправку в конце транзакции
            TransactionEventPublisher.registerSynchronization();
        }
        if (entity instanceof INotifyBot notifiable) {
            switch (action) {
                case CREATED: notifiable.getNotify().map(INotifyBot.NotifyAggregate::create).ifPresent(Event::publish);
                case UPDATED: notifiable.getNotify().map(INotifyBot.NotifyAggregate::update).ifPresent(Event::publish);
                case DELETED: notifiable.getNotify().map(INotifyBot.NotifyAggregate::delete).ifPresent(Event::publish);
            }
        }
    }

    enum EventType {
        CREATED,
        UPDATED,
        DELETED
    }
}
