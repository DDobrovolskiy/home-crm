package ru.dda.homecrmback.domain.support.role;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.support.result.Result;
import ru.dda.homecrmback.domain.support.result.aggregate.IFailAggregate;
import ru.dda.homecrmback.domain.support.role.aggregate.RoleAggregate;

public interface Role {

    @Builder
    record FindById(
            Long roleId
    ) {

        public static FindById of(Long roleId) {
            return new FindById(roleId);
        }

        public Result<RoleAggregate, IFailAggregate> execute(RoleService service) {
            return service.findById(this);
        }
    }

    @Builder
    record FindByIdAndOrganizationId(
            Long roleId,
            Long organizationId
    ) implements IExecute<FindByIdAndOrganizationId> {
        public static FindByIdAndOrganizationId of(Long roleId, Long organizationId) {
            return new FindByIdAndOrganizationId(roleId, organizationId);
        }
    }

    @Builder
    record FindByNameAndOrganizationId(
            String roleName,
            Long organizationId
    ) {

        public static FindByNameAndOrganizationId of(String roleName, Long organizationId) {
            return new FindByNameAndOrganizationId(roleName, organizationId);
        }

        public Result<RoleAggregate, IFailAggregate> execute(RoleService service) {
            return service.findByNameAndOrganizationId(this);
        }
    }
}
