package ru.dda.homecrmback.domain.subdomain.scope.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.scope.dto.ScopeDTO;
import ru.dda.homecrmback.domain.subdomain.scope.enums.ScopeType;
import ru.dda.homecrmback.domain.support.aggregete.IAggregate;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "scope")
public class ScopeAggregate implements IAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    @Enumerated(EnumType.STRING)
    private ScopeType type;

    @Transient
    public ScopeDTO getScopeDTO() {
        return ScopeDTO.builder()
                .id(id)
                .name(type.name())
                .description(type.getDescription())
                .build();
    }
}
