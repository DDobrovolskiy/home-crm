package ru.dda.homecrmback.domain.support.aggregete;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionSynchronizationManager;

@Service
@RequiredArgsConstructor
public class TransactionEventPublisher {

    /**
     * Статический метод для регистрации синхронизации,
     * чтобы не делать это повторно для каждой сущности.
     */
    public static void registerSynchronization() {
        if (!TransactionSynchronizationManager.isSynchronizationActive()) return;

        // Проверяем, не зарегистрирована ли уже наша синхронизация
        boolean alreadyRegistered = TransactionSynchronizationManager.getSynchronizations()
                .stream()
                .anyMatch(s -> s instanceof TransactionEventSync);

        if (!alreadyRegistered) {
            TransactionSynchronizationManager.registerSynchronization(
                    BeanUtil.getBean(TransactionEventSync.class)
            );
        }
    }
}
