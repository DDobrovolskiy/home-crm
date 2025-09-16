package ru.dda.homecrmback.domain.subdomain.education.dto.request;

import java.util.List;

public record EducationTestSessionResultDTO(
        long sessionId,
        List<EducationTestSessionResultQuestionDTO> questions
) {
}
