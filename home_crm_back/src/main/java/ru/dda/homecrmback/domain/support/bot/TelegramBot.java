package ru.dda.homecrmback.domain.support.bot;

import org.springframework.beans.factory.annotation.Value;
import org.telegram.telegrambots.bots.TelegramLongPollingBot;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Update;
import org.telegram.telegrambots.meta.exceptions.TelegramApiException;

public class TelegramBot extends TelegramLongPollingBot {
    @Value("${bot.name}")
    private String botUsername;

    public TelegramBot(String botToken) {
        super(botToken);
    }

    @Override
    public void onUpdateReceived(Update update) {
        System.out.printf("onUpdateReceived %s%n", update);
        try {
            if (update.hasMessage() && update.getMessage().hasText()) {
                long chatId = update.getMessage().getChatId();
                System.out.println("Chat ID пользователя: " + chatId);
            }
            SendMessage sendMessage = new SendMessage();
            sendMessage.setChatId(update.getMessage().getChatId().toString());
            sendMessage.setText("Hi!");
            execute(sendMessage);
        } catch (TelegramApiException e) {
            e.printStackTrace();
        }
    }

    public void sendNotification(Long chatId, String text) {
        SendMessage message = new SendMessage();
        message.setChatId(chatId.toString());
        message.setText(text);
        message.setParseMode("HTML"); // Для красоты (жирный шрифт, ссылки)
        try {
            execute(message);
        } catch (TelegramApiException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getBotUsername() {
        return botUsername;
    }
}
