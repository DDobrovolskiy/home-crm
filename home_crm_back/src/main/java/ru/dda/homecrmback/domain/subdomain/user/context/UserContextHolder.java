package ru.dda.homecrmback.domain.subdomain.user.context;

public class UserContextHolder {

    private static final ThreadLocal<UserInfo> currentUser = new ThreadLocal<>();

    public static void setCurrentUser(UserInfo user) {
        currentUser.set(user);
    }

    public static UserInfo getCurrentUser() {
        return currentUser.get();
    }

    public static void clear() {
        currentUser.remove();
    }
}
