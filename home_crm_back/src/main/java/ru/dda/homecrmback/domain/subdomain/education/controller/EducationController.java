package ru.dda.homecrmback.domain.subdomain.education.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.education.Education;
import ru.dda.homecrmback.domain.subdomain.education.EducationService;
import ru.dda.homecrmback.domain.subdomain.education.aggregate.TestAggregate;
import ru.dda.homecrmback.domain.subdomain.education.dto.request.EducationTestCreateDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.request.EducationTestDeleteDTO;
import ru.dda.homecrmback.domain.subdomain.education.dto.response.EducationTestDTO;
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
                .execute(educationService::find)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping(path = "/test")
    private IResponse<EducationTestDTO> createTest(@RequestBody EducationTestCreateDTO dto) {
        return Education.Test.Create.of(dto.name())
                .execute(educationService::create)
                .map(TestAggregate::getEducationTestDTO)
                .response(ResultAggregate::getErrorData);
    }

//    @PutMapping(path = "/test")
//    public IResponse<EducationTestDTO> updateOrganization(@RequestBody EmployeeUpdateDTO dto) {
//        return Employee.Update.of(dto.id(), dto.roleId())
//                .execute(employeeService::update)
//                .map(EmployeeAggregate::getEmployeeDTO)
//                .response(ResultAggregate::getErrorData);
//    }

    @DeleteMapping(path = "/test")
    public IResponse<Integer> deleteOrganization(@RequestBody EducationTestDeleteDTO dto) {
        return Education.Test.Delete.of(dto.id())
                .execute(educationService::delete)
                .response(ResultAggregate::getErrorData);
    }
}
