package ru.dda.homecrmback.domain.support.scope.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.support.scope.ScopeType;

@Slf4j
@Getter
@Setter
@Entity
@Table(name = "scope")
public class ScopeAggregate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    @Enumerated(EnumType.STRING)
    private ScopeType type;
}
