package ru.dda.homecrmback.domain.subdomain.organization;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
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
    record Update(
            FindById organization,
            String organizationName,
            User.FindById owner
    ) implements IExecute<Update> {
        public static Update of(long organizationId, String organizationName, long ownerId) {
            return new Update(Organization.FindById.of(organizationId), organizationName, User.FindById.of(ownerId));
        }
    }

    @Builder
    record Delete(
            FindById organization,
            User.FindById owner
    ) implements IExecute<Delete> {
        public static Delete of(long organizationId, long ownerId) {
            return new Delete(Organization.FindById.of(organizationId), User.FindById.of(ownerId));
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
