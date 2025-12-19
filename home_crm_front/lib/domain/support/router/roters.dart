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
  static const String employees = '/employees';
  static const String employee =
      '/organization/employee/:employeeId';
  static const String employeeTests =
      '/organization/employee/tests';
  static const String employeeTestRun =
      '/organization/employee/:employeeId/test/:testId/run';
  static const String roles =
      'roles';
  static const String role =
      '/organization/role/:roleId';
  static const String tests =
      'tests';
  static const String test =
      '/organization/tests/:testId';
  static const String question =
      '/organization/tests/:testId/:questionId';
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  late final TokenService _tokenService = GetIt.instance.get<TokenService>();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthLoginRoute.page, path: RoutersApp.login, initial: true),
    AutoRoute(page: AuthCreateRoute.page, path: RoutersApp.registration),

    AutoRoute(page: UserProfileRoute.page, path: RoutersApp.user),
    AutoRoute(page: OrganizationRoute.page, path: RoutersApp.organization),
    AutoRoute(page: HomeRoute.page, path: RoutersApp.home, children: [
      AutoRoute(
          page: NewsRoute.page, path: ''),
      AutoRoute(
          page: OrganizationRolesRoute.page, path: RoutersApp.roles),
      AutoRoute(page: OrganizationTestsRoute.page, path: RoutersApp.tests),
    ]),
    AutoRoute(
        page: OrganizationEmployeesRoute.page, path: RoutersApp.employees),
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
          (resolver.routeName != AuthLoginRoute.name &&
              resolver.routeName != AuthCreateRoute.name)) {
        resolver.redirect(AuthLoginRoute());
      } else if (organizationToken == null &&
          (resolver.routeName != UserProfileRoute.name &&
              resolver.routeName != OrganizationRoute.name &&
              resolver.routeName != AuthLoginRoute.name &&
              resolver.routeName != AuthCreateRoute.name)) {
        resolver.redirect(UserProfileRoute());
      } else {
        resolver.next();
      }
    }),
  ];
}
