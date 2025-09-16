package ru.dda.homecrmback.domain.subdomain.employee.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import ru.dda.homecrmback.domain.subdomain.employee.Employee;
import ru.dda.homecrmback.domain.subdomain.employee.EmployeeService;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.dto.request.EmployeeCreateDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.request.EmployeeDeleteDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.request.EmployeeUpdateDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeTestViewDTO;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.response.IResponse;

@RestController
@RequestMapping(EmployeeController.PATH)
@RequiredArgsConstructor
public class EmployeeController {
    public static final String PATH = "/employee";

    private final EmployeeService employeeService;

    @GetMapping(path = "/{id}")
    private IResponse<EmployeeDTO> getEmployee(@PathVariable Long id) {
        return Employee.Find.of(id)
                .execute(employeeService::find)
                .map(EmployeeAggregate::getEmployeeDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping()
    private IResponse<EmployeeDTO> getCurrentEmployee() {
        return Employee.Current.of()
                .execute(employeeService::current)
                .map(EmployeeAggregate::getEmployeeDTO)
                .response(ResultAggregate::getErrorData);
    }

    @GetMapping(path = "/tests")
    private IResponse<EmployeeTestViewDTO> getCurrentEmployeeTest() {
        return Employee.Current.of()
                .execute(employeeService::current)
                .map(EmployeeAggregate::getEmployeeTestViewDTO)
                .response(ResultAggregate::getErrorData);
    }

    @PostMapping
    private IResponse<EmployeeDTO> registrationEmployee(@RequestBody EmployeeCreateDTO dto) {
        return Employee.Create.of(dto.name(), dto.phone(), dto.password(), dto.roleId())
                .execute(employeeService::create)
                .map(EmployeeAggregate::getEmployeeDTO)
                .response(ResultAggregate::getErrorData);
    }


    @PutMapping
    public IResponse<EmployeeDTO> updateOrganization(@RequestBody EmployeeUpdateDTO dto) {
        return Employee.Update.of(dto.id(), dto.roleId())
                .execute(employeeService::update)
                .map(EmployeeAggregate::getEmployeeDTO)
                .response(ResultAggregate::getErrorData);
    }

    @DeleteMapping
    public IResponse<Integer> deleteOrganization(@RequestBody EmployeeDeleteDTO dto) {
        return Employee.Delete.of(dto.id())
                .execute(employeeService::delete)
                .response(ResultAggregate::getErrorData);
    }
}
