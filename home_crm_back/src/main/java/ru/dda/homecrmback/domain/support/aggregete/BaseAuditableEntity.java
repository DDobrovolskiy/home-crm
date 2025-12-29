package ru.dda.homecrmback.domain.support.aggregete;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;

@MappedSuperclass
@EntityListeners(AuditEntityListener.class)
@Getter
@Setter
public abstract class BaseAuditableEntity implements IAggregate {

    @NotNull
    @Fetch(FetchMode.JOIN)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    private OrganizationAggregate organization;

    // active = true (живая сущность), active = false (удалена)
    @Column(name = "active", nullable = false)
    private boolean active = true;

    @Transient
    public abstract String getEntityName();
}
