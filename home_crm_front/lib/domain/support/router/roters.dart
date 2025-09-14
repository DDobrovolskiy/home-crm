import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../token_service.dart';

class RoutersApp {
  static const String registration = '/register';
  static const String login = '/login';

  static const String user = '/user';
  static const String organization = '/organization';
  static const String home = '/home';
  static const String employees =
      '/organization/employees';
  static const String employee =
      '/organization/employee/:employeeId';
  static const String roles =
      '/organization/roles';
  static const String role =
      '/organization/role/:roleId';
  static const String test =
      '/organization/tests';
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  late final TokenService _tokenService = GetIt.instance.get<TokenService>();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, path: RoutersApp.login, initial: true),
    AutoRoute(page: RegistrationRoute.page, path: RoutersApp.registration),

    AutoRoute(page: UserRoute.page, path: RoutersApp.user),
    AutoRoute(page: OrganizationRoute.page, path: RoutersApp.organization),
    AutoRoute(page: HomeRoute.page, path: RoutersApp.home),
    AutoRoute(
        page: OrganizationEmployeesRoute.page, path: RoutersApp.employees),
    AutoRoute(
        page: OrganizationRolesRoute.page, path: RoutersApp.roles),
    AutoRoute(page: EmployeeRoute.page, path: RoutersApp.employee),
    AutoRoute(page: RoleRoute.page, path: RoutersApp.role),
    AutoRoute(page: OrganizationTestsRoute.page, path: RoutersApp.test),
  ];

  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple((resolver, router) async {
      String? authToken = await _tokenService.getToken(TokenService.authToken);
      String? userToken = await _tokenService.getToken(TokenService.userToken);
      String? organizationToken = await _tokenService.getToken(
        TokenService.organizationToken,
      );
      if ((authToken == null || userToken == null) &&
          (resolver.routeName != LoginRoute.name &&
              resolver.routeName != RegistrationRoute.name)) {
        resolver.redirect(LoginRoute());
      } else if (organizationToken == null &&
          (resolver.routeName != UserRoute.name &&
              resolver.routeName != OrganizationRoute.name &&
              resolver.routeName != LoginRoute.name &&
              resolver.routeName != RegistrationRoute.name)) {
        resolver.redirect(UserRoute());
      } else {
        resolver.next();
      }
    }),
  ];
}
