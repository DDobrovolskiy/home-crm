package ru.dda.homecrmback.domain.support.aggregete;

import java.io.Serializable;
import java.util.Comparator;

public interface IAggregate extends Comparable<IAggregate>, Serializable {
    Long getId();

    @Override
    default int compareTo(IAggregate o) {
        return Comparator.<Long>naturalOrder().compare(getId(), o.getId());
    }
}
