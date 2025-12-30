package ru.dda.homecrmback.domain.support.aggregete.entity;

import jakarta.persistence.EntityListeners;
import jakarta.persistence.Transient;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.support.aggregete.IAggregate;
import ru.dda.homecrmback.domain.support.aggregete.listeners.EntityListener;

@EntityListeners(EntityListener.class)
public interface IAuditableEntity extends IAggregate {
    OrganizationAggregate getOrganization();
    @Transient
    String getEntityName();
}