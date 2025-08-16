package ru.dda.homecrmback.domain.subdomain.organization;

import lombok.Builder;
import ru.dda.homecrmback.domain.support.IExecute;
import ru.dda.homecrmback.domain.support.user.User;

public interface Organization {

    @Builder
    record Create(
            String organizationName,
            User.FindById owner
    ) implements IExecute<Create> {
        public static Create of(String organizationName, long ownerId) {
            return new Create(organizationName, User.FindById.of(ownerId));
        }
    }

    @Builder
    record FindById(
            long organizationId
    ) implements IExecute<FindById> {

        public static FindById of(long organizationId) {
            return new FindById(organizationId);
        }
    }

    @Builder
    record FindOwnerOrganization(
            long ownerId
    ) implements IExecute<FindOwnerOrganization> {
        public static FindOwnerOrganization of(long ownerId) {
            return new FindOwnerOrganization(ownerId);
        }
    }

}
