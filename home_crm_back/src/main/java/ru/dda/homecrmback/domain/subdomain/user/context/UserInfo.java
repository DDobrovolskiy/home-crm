package ru.dda.homecrmback.domain.subdomain.user.context;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserInfo {
    private long userId;
    private long organizationId;
    private long roleId;
}
