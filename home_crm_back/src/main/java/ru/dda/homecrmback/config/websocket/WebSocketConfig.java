package ru.dda.homecrmback.config.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        ThreadPoolTaskScheduler te = new ThreadPoolTaskScheduler();
        te.setPoolSize(1);
        te.setThreadNamePrefix("ws-heartbeat-thread-");
        te.initialize();

        config.enableSimpleBroker("/out")
                .setHeartbeatValue(new long[]{10000, 10000}) // 10 сек туда и обратно
                .setTaskScheduler(te); // Планировщик для рассылки пингов

        config.setApplicationDestinationPrefixes("/app");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // Точка подключения. Для мобильных приложений (Flutter)
        // обычно лучше использовать чистый WebSocket без SockJS,
        // если библиотека на стороне Dart это поддерживает.
        registry.addEndpoint("/ws-endpoint").setAllowedOrigins("*");
    }
}
