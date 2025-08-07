package ru.dda.homecrmback.domain.support.result.aggregate;

import lombok.Getter;
import ru.dda.homecrmback.domain.support.result.dto.ErrorData;
import ru.dda.homecrmback.domain.support.result.dto.Fail;

import java.util.LinkedList;
import java.util.List;

public interface ResultAggregate {

    ErrorData getErrorData();

    interface Fails {

        @Getter
        class Default implements IFailAggregate {
            private List<Fail> events = new LinkedList<>();
            private int status = 1;

            public static Default of(Fail event) {
                return new Default().addEvent(event);
            }

            public static Default of(List<Fail> events) {
                Default aDefault = new Default();
                aDefault.events = events;
                return aDefault;
            }

            Default addEvent(Fail failEvent) {
                this.events.add(failEvent);
                return this;
            }

            @Override
            public ErrorData getErrorData() {
                return ErrorData.of(events);
            }
        }
    }
}
