package ru.dda.homecrmback.domain.support.bot;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TelegramBotConfig {
    @Value("${bot.token}")
    private String botToken;

    @Bean
    public TelegramBot getTelegramBot(){
        return new TelegramBot(botToken);
    }
}
