package ru.dda.homecrmback.domain.support.aggregete.entity;

import jakarta.persistence.EntityListeners;
import jakarta.persistence.MappedSuperclass;
import lombok.Getter;
import lombok.Setter;
import ru.dda.homecrmback.domain.support.aggregete.IAggregate;
import ru.dda.homecrmback.domain.support.aggregete.listeners.EntityListener;

@MappedSuperclass
@EntityListeners(EntityListener.class)
@Getter
@Setter
public abstract class SubscribesEntity implements IAggregate {

}

