package ru.dda.homecrmback.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import ru.dda.homecrmback.domain.support.api.Api;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")  // Применять ко всем маршрутам
                .allowedOrigins("*")  // Разрешенные домены
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")  // Доступные методы
                .allowedHeaders("Content-Type", Api.AUTHORIZATION_HEADER, Api.ORGANIZATION_HEADER)  // Разрешенные заголовки
                .maxAge(3600);  //
    }
}