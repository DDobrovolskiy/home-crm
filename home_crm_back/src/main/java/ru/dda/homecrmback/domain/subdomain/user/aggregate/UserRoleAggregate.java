package ru.dda.homecrmback.domain.subdomain.user.aggregate;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;
import ru.dda.homecrmback.domain.subdomain.user.context.IUserContext;
import ru.dda.homecrmback.domain.subdomain.user.context.UserInfo;

@Entity
@Immutable
@Table(name = "user_role_view")
public class UserRoleAggregate implements IUserContext {
    @Id
    private long userId;
    private long organizationId;
    private long roleId;

    @Override
    public UserInfo getUserInfo() {
        return UserInfo.builder()
                .userId(userId)
                .organizationId(organizationId)
                .roleId(roleId)
                .build();
    }
}
