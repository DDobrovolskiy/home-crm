package ru.dda.homecrmback.config.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import ru.dda.homecrmback.config.websocket.dto.MessageDto;

@Slf4j
@Controller
public class OrganizationChatController {

    private final SimpMessagingTemplate messagingTemplate;

    @Autowired
    public OrganizationChatController(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @MessageMapping("/in/{idOrganization}")
    public void handleMessage(@DestinationVariable String idOrganization, MessageDto message) {
        // Логика: получаем сообщение, возможно сохраняем в БД
        log.info("Сообщение для организации {} : {}", idOrganization, message);
        // Рассылаем всем подписанным на этот конкретный idOrganization
        messagingTemplate.convertAndSend("/out/%s".formatted(idOrganization), message);
    }
}
