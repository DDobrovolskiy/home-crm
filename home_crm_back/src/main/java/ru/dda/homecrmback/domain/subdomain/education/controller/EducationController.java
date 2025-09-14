package ru.dda.homecrmback.domain.subdomain.education.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.education.Education;
import ru.dda.homecrmback.domain.subdomain.education.EducationService;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.QuestionAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.education.dto.request.*;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationQuestionViewDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestEditDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(EducationController.PATH)
@RequiredArgsConstructor
public class EducationController {
    public static final String PATH = "/education";

    private final EducationService educationService;

    @GetMapping(path = "/test/{id}")
    private IResponse<EducationTestEditDTO> getTest(@PathVariable long id) {
        return Education.Test.Find.of(id)
                .execute(educationService::findTest)
                .map(TestAggregate::getEducationTestEditDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping(path = "/test")
    private IResponse<EducationTestDTO> createTest(@RequestBody EducationTestCreateDTO dto) {
        return Education.Test.Create.of(dto.name())
                .execute(educationService::createTest)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PutMapping(path = "/test")
    public IResponse<EducationTestDTO> updateTest(@RequestBody EducationTestUpdateDTO dto) {
        return Education.Test.Update.of(dto.id(), dto.name(), dto.timeLimitMinutes())
                .execute(educationService::updateTest)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PutMapping(path = "/test/ready")
    public IResponse<EducationTestDTO> updateTest(@RequestBody EducationTestUpdateReadyDTO dto) {
        return Education.Test.UpdateReady.of(dto.id(), dto.ready())
                .execute(educationService::readyTest)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping(path = "/test")
    public IResponse<Integer> deleteTest(@RequestBody EducationTestDeleteDTO dto) {
        return Education.Test.Delete.of(dto.id())
                .execute(educationService::deleteTest)
                .response(ResultAggregate::getErrorData);
    }


    @GetMapping(path = "/test/{testId}/qustions/{id}")
    private IResponse<EducationQuestionViewDTO> getTestQuestion(@PathVariable long testId, @PathVariable long id) {
        return Education.Question.Find.of(id, testId)
                .execute(educationService::findQuestion)
                .map(QuestionAggregate::getEducationQuestionViewDTO)
                .response(ResultAggregate::getErrorData);
    }


    @PostMapping(path = "/question")
    private IResponse<EducationQuestionDTO> createQuestion(@RequestBody EducationQuestionCreateDTO dto) {
        return Education.Question.Create.of(dto.text(), dto.testId())
                .execute(educationService::createQuestion)
                .map(QuestionAggregate::getEducationQuestionDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PutMapping(path = "/question")
    public IResponse<EducationTestDTO> updateQuestion(@RequestBody EducationTestUpdateDTO dto) {
        return Education.Test.Update.of(dto.id(), dto.name(), dto.timeLimitMinutes())
                .execute(educationService::updateTest)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping(path = "/question")
    public IResponse<Integer> deleteQuestion(@RequestBody EducationTestDeleteDTO dto) {
        return Education.Test.Delete.of(dto.id())
                .execute(educationService::deleteTest)
                .response(ResultAggregate::getErrorData);
    }
}
