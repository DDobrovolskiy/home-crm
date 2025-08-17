package ru.dda.homecrmback.domain.support.user.aggregate;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Singular;
import lombok.experimental.SuperBuilder;
import lombok.extern.slf4j.Slf4j;
import ru.dda.homecrmback.domain.subdomain.employee.aggregate.EmployeeAggregate;
import ru.dda.homecrmback.domain.subdomain.employee.dto.response.EmployeeDTO;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.dto.response.OrganizationInfoDTO;
import ru.dda.homecrmback.domain.support.auth.dto.SimpleLoginDTO;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.result.validator.Validator;
import ru.dda.homecrmback.domain.support.user.context.IUserContext;
import ru.dda.homecrmback.domain.support.user.context.UserInfo;

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
    private List<OrganizationAggregate> organizations = new ArrayList<>();
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE, orphanRemoval = true)
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

    public Result<String, IFailAggregate> login(SimpleLoginDTO dto) {
        if (Objects.equals(password, dto.password())) {
            return Result.success(token);
        }
        return Result.fail(ResultAggregate.Fails.Default.of(FailEvent.WRONG_PASSWORD.fail()));
    }

    public boolean logout() {
        token = UUID.randomUUID().toString();
        return true;
    }

    public DTO.UserBaseDTO getUserDTO() {
        return DTO.UserBaseDTO.builder()
                .id(id)
                .phone(phone)
                .name(name)
                .build();
    }

    public DTO.UserDTO userOrganizationDTO() {
        return DTO.UserDTO.builder()
                .id(id)
                .name(name)
                .phone(phone)
                .ownerOrganizations(organizations.stream()
                        .map(OrganizationAggregate::organizationInfoDTO)
                        .toList())
                .employeeOrganizations(empolyees.stream()
                        .map(EmployeeAggregate::getEmployeeDTO)
                        .toList())
                .build();
    }

    public UserInfo getUserInfo() {
        return UserInfo.builder()
                .userId(id)
                .build();
    }

    public interface DTO {
        // Базовый класс с общей информацией
        // Расширенный класс с дополнительными списками

        @Getter
        @SuperBuilder
        class UserBaseDTO {
            private Long id;
            private String name;
            private String phone;
        }

        @Getter
        @SuperBuilder
        class UserDTO extends UserBaseDTO {
            @Singular
            private List<OrganizationInfoDTO> ownerOrganizations;
            @Singular
            private List<EmployeeDTO> employeeOrganizations;
        }
    }
}
