package ru.dda.homecrmback.domain.subdomain.user.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.BatchSize;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.user.context.IUserContext;
import ru.dda.homecrmback.domain.subdomain.user.context.UserInfo;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserAggregateDTO;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserDTO;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserEmployeesDTO;
import ru.dda.homecrmback.domain.subdomain.user.dto.response.UserOrganizationsDTO;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.auth.dto.response.AuthSuccessDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Slf4j
@Getter
@Entity
@Table(name = "users")
public class UserAggregate implements IUserContext {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull
    private String token = UUID.randomUUID().toString();
    @NotNull
    private String phone;
    @NotNull
    private String password;
    @NotNull
    private String name;
    @OneToMany(mappedBy = "owner", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE, orphanRemoval = true)
    @BatchSize(size = 20)
    private List<OrganizationAggregate> organizations = new ArrayList<>();
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE, orphanRemoval = true)
    @BatchSize(size = 20)
    private List<EmployeeAggregate> empolyees = new ArrayList<>();

    public static Result<UserAggregate, IFailAggregate> create(String name, String phone, String password) {
        return Validator.create()
                .is(name != null,
                        () -> log.debug("name is null"),
                        FailEvent.VALIDATION.fail("Имя не заполнено"))
                .is(password != null,
                        () -> log.debug("password is null"),
                        FailEvent.VALIDATION.fail("Пароль не заполнен"))
                .is(phone != null,
                        () -> log.debug("phone is null"),
                        FailEvent.VALIDATION.fail("Номер телефона не заполнен"))
                .getResult(() -> {
                    UserAggregate aggregate = new UserAggregate();
                    aggregate.name = name;
                    aggregate.phone = phone;
                    aggregate.password = password;
                    return aggregate;
                });
    }

    public Result<AuthSuccessDTO, IFailAggregate> login(SimpleLoginDTO dto) {
        if (Objects.equals(password, dto.password())) {
            return Result.success(this.getAuthSuccessDTO());
        }
        return Result.fail(ResultAggregate.Fails.Default.of(FailEvent.WRONG_PASSWORD.fail()));
    }

    public boolean logout() {
        token = UUID.randomUUID().toString();
        return true;
    }

    public UserDTO getUserDTO() {
        return UserDTO.builder()
                .id(id)
                .phone(phone)
                .name(name)
                .build();
    }

    public UserOrganizationsDTO getUserOrganizationsDTO() {
        return UserOrganizationsDTO.builder()
                .organizations(organizations.stream()
                        .map(OrganizationAggregate::organizationDTO)
                        .toList())
                .build();
    }

    public UserEmployeesDTO getUserEmployeesDTO() {
        return UserEmployeesDTO.builder()
                .employees(empolyees.stream()
                        .map(EmployeeAggregate::getEmployeeDTO)
                        .toList())
                .build();
    }

    public UserInfo getUserInfo() {
        return UserInfo.builder()
                .userId(id)
                .build();
    }

    public AuthSuccessDTO getAuthSuccessDTO() {
        return AuthSuccessDTO.builder()
                .token(token)
                .userId(id)
                .build();
    }

    public UserAggregateDTO getUserAggregateDTO() {
        return UserAggregateDTO.builder()
                .id(id)
//                .active()
//                .version()
//                .createdAt()
                .name(name)
//                .surname()
//                .patronymic()
                .phone(phone)
                .build();
    }
}
