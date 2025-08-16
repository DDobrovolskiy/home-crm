package ru.dda.homecrmback.domain.subdomain.organization;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.dda.homecrmback.domain.subdomain.organization.aggregate.OrganizationAggregate;
import ru.dda.homecrmback.domain.subdomain.organization.repository.OrganizationRepository;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.result.aggregate.ResultAggregate;
import ru.dda.homecrmback.domain.support.result.events.FailEvent;
import ru.dda.homecrmback.domain.support.role.RoleService;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;
import ru.dda.homecrmback.domain.support.user.UserDomainService;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class OrganizationService {
    private final OrganizationRepository organizationRepository;
    private final UserDomainService userDomainService;
    private final RoleService roleService;

    @Transactional
    public Result<OrganizationAggregate, IFailAggregate> create(Organization.Create command) {
        return command.owner().execute(userDomainService::getUserAggregateById)
                .then(owner -> OrganizationAggregate.create(owner, command.organizationName()))
                .then(organizationAggregate -> {
                    try {
                        return Result.success(organizationRepository.save(organizationAggregate));
                    } catch (Exception e) {
                        log.error(e.getMessage(), e);
                        return Result.fail(ResultAggregate.Fails.Default.of(
                                FailEvent.ERROR_ON_SAVE.fail("Ошибка сохранения организации")));
                    }
                })
                .peekThen(organizationAggregate -> roleService.create(RoleAggregate.Command.Create.builder()
                        .name("Сотрудник")
                        .description("Сотрудник организации")
                        .organization(organizationAggregate)
                        .build()))
                .rollbackIfError();
    }

    @Transactional
    public Result<OrganizationAggregate, IFailAggregate> findById(Organization.FindById command) {
        return organizationRepository.findById(command.organizationId())
                .map(Result::<OrganizationAggregate, IFailAggregate>success)
                .orElseGet(() -> Result.fail(ResultAggregate.Fails.Default.of(FailEvent.ORGANIZATION_NOT_FOUND.fail())));
    }

    @Transactional
    public List<OrganizationAggregate> findOwnerOrganization(Organization.FindOwnerOrganization command) {
        return organizationRepository.findAllByOwnerId(command.ownerId());
    }
}
