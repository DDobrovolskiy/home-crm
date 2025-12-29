package ru.dda.homecrmback.domain.support.aggregete;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.support.TransactionSynchronization;
import ru.dda.homecrmback.config.websocket.OrganizationChatController;
import ru.dda.homecrmback.config.websocket.dto.MessageDto;

@Component
@RequiredArgsConstructor
public class TransactionEventSync implements TransactionSynchronization {

    private final OrganizationChatController messagingTemplate;
    private final TransactionEventBuffer eventBuffer;

    @Override
    public void afterCommit() {
        Long orgId = eventBuffer.getOrganizationId();
        if (orgId == null || eventBuffer.getBuffer().isEmpty()) return;

        // Отправляем по одному сообщению на каждый тип сущности
        eventBuffer.getBuffer().forEach((entityName, ids) -> {
            MessageDto message = MessageDto.builder()
                    .name(entityName)
                    .ids(ids)
                    .build();
            messagingTemplate.handleMessage(String.valueOf(orgId), message);
        });
    }
}
