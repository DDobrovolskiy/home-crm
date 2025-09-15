package ru.dda.homecrmback.domain.subdomain.education.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.education.Education;
import ru.dda.homecrmback.domain.subdomain.education.EducationService;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.OptionAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.QuestionAggregate;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.education.dto.request.*;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.*;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(EducationController.PATH)
@RequiredArgsConstructor
public class EducationController {
    public static final String PATH = "/education";

    private final EducationService educationService;

    @GetMapping(path = "/test/{id}")
    private IResponse<EducationTestDTO> getTest(@PathVariable long id) {
        return Education.Test.Find.of(id)
                .execute(educationService::findTest)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping(path = "/test/{id}/questions")
    private IResponse<EducationTestQuestionsDTO> getTestQuestions(@PathVariable long id) {
        return Education.Test.Find.of(id)
                .execute(educationService::findTest)
                .map(TestAggregate::getEducationTestQuestionsDTO)
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


    @GetMapping(path = "/question/{id}")
    private IResponse<EducationQuestionDTO> getTestQuestion(@PathVariable long id) {
        return Education.Question.Find.of(id)
                .execute(educationService::findQuestion)
                .map(QuestionAggregate::getEducationQuestionDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping(path = "/question/{id}/options")
    private IResponse<EducationQuestionOptionsDTO> getQuestionOptions(@PathVariable long id) {
        return Education.Question.Find.of(id)
                .execute(educationService::findQuestion)
                .map(QuestionAggregate::getEducationQuestionOptionsDTO)
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
    public IResponse<EducationQuestionDTO> updateQuestion(@RequestBody EducationQuestionUpdateDTO dto) {
        return Education.Question.Update.of(dto.id(), dto.text())
                .execute(educationService::updateQuestion)
                .map(QuestionAggregate::getEducationQuestionDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping(path = "/question")
    public IResponse<Integer> deleteQuestion(@RequestBody EducationQuestionDeleteDTO dto) {
        return Education.Question.Delete.of(dto.id())
                .execute(educationService::deleteQuestion)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping(path = "/option/{id}")
    private IResponse<EducationOptionDTO> getOption(@PathVariable long id) {
        return Education.Option.Find.of(id)
                .execute(educationService::findOption)
                .map(OptionAggregate::getEducationOptionDTO)
                .response(ResultAggregate::getErrorData);
    }


    @PostMapping(path = "/option")
    private IResponse<EducationOptionDTO> createOption(@RequestBody EducationOptionCreateDTO dto) {
        return Education.Option.Create.of(dto.text(), dto.correct(), dto.questionId())
                .execute(educationService::createOption)
                .map(OptionAggregate::getEducationOptionDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PutMapping(path = "/option")
    public IResponse<EducationOptionDTO> updateOption(@RequestBody EducationOptionUpdateDTO dto) {
        return Education.Option.Update.of(dto.id(), dto.text(), dto.correct())
                .execute(educationService::updateOption)
                .map(OptionAggregate::getEducationOptionDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping(path = "/option")
    public IResponse<Integer> deleteOption(@RequestBody EducationOptionDeleteDTO dto) {
        return Education.Option.Delete.of(dto.id())
                .execute(educationService::deleteOption)
                .response(ResultAggregate::getErrorData);
    }
}
