package ru.dda.homecrmback.domain.subdomain.employee.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.dda.homecrmback.domain.subdomain.employee.Employee;
import ru.dda.homecrmback.domain.subdomain.employee.EmployeeService;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.dto.RegistrationEmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(EmployeeController.PATH)
@RequiredArgsConstructor
public class EmployeeController {
    public static final String PATH = "/employee";

    private final EmployeeService employeeService;

    @PostMapping(path = "/registration")
    private IResponse<EmployeeDTO> registrationEmployee(@RequestBody RegistrationEmployeeDTO dto) {
        return Employee.Registration.of(dto.name(), dto.phone(), dto.password(), dto.roleId())
                .execute(employeeService::registrationEmployee)
                .map(EmployeeAggregate::getEmployeeDTO)
                .response(ResultAggregate::getErrorData);
    }
}
