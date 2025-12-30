package ru.dda.homecrmback.domain.support.aggregete.entity;

import jakarta.persistence.Transient;
import lombok.Builder;
import lombok.RequiredArgsConstructor;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.support.aggregete.NotifyType;

import java.util.Optional;
import java.util.function.Function;


public interface INotifyBot {
    @Transient
    Optional<NotifyAggregate> getNotify();

    interface Handler {
        Notify create();
        Notify update();
        Notify delete();
    }

    @Builder
    record Notify(
            NotifyTarget employeeNotify,
            NotifyTarget organizationNotify

    ) {}

    @Builder
    record NotifyTarget(
            Long id,
            NotifyType notifyType,
            Function<MessageBuilder, String> message
    ) {}

    interface MessageBuilder {
        OrganizationAggregate getOrganization(Long id);
        RoleAggregate getRole(Long id);
    }

    interface NotifyAggregate extends Handler {
        @RequiredArgsConstructor(staticName = "of")
        class Employee implements NotifyAggregate {
            private final Long employeeNotify;
            private final Long organizationNotify;
            private final Long currentRole;

            @Override
            public Notify create() {
                return Notify.builder()
                        .employeeNotify(NotifyTarget.builder()
                                .id(employeeNotify)
                                .notifyType(NotifyType.EMPLOYEE)
                                .message(messageBuilder -> "Вы приняты на работу в %s на долженность %s"
                                        .formatted(
                                                messageBuilder.getOrganization(organizationNotify).getName(),
                                                messageBuilder.getRole(currentRole).getName()))
                                .build())
                        .organizationNotify(NotifyTarget.builder()
                                .id(organizationNotify)
                                .notifyType(NotifyType.EMPLOYEE_CHANGED)
                                .message(messageBuilder -> "Добавлен новый сотрудник на долженность: %s"
                                        .formatted(
                                                messageBuilder.getRole(currentRole).getName()))
                                .build())
                        .build();
            }

            @Override
            public Notify update() {
                return null;
            }

            @Override
            public Notify delete() {
                return null;
            }
        }
    }
}
