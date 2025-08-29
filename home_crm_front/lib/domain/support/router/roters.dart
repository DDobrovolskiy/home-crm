import 'package:auto_route/auto_route.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../token_service.dart';

class RoutersApp {
  static const String registration = '/register';
  static const String login = '/login';
  static const String user = '/user';
  static const String organization = '/organization';
  static const String home = '/';
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final TokenService _tokenService = TokenService();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RegistrationRoute.page, path: RoutersApp.registration),
    AutoRoute(page: LoginRoute.page, path: RoutersApp.login),
    AutoRoute(page: UserRoute.page, path: RoutersApp.user),
    AutoRoute(page: HomeRoute.page, path: RoutersApp.home),
    AutoRoute(page: OrganizationRoute.page, path: RoutersApp.organization),
  ];

  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple((resolver, router) async {
      String? token = await _tokenService.getToken(TokenService.authToken);
      if (token != null ||
          resolver.routeName == LoginRoute.name ||
          resolver.routeName == RegistrationRoute.name) {
        resolver.next();
      } else {
        // resolver.redirect(LoginRoute(onResult: (didLogin) => resolver.next(didLogin)));
        resolver.redirect(LoginRoute());
      }
    }),
    AutoRouteGuard.simple((resolver, router) async {
      String? token = await _tokenService.getToken(
        TokenService.organizationToken,
      );
      if (token != null ||
          resolver.routeName == LoginRoute.name ||
          resolver.routeName == RegistrationRoute.name ||
          resolver.routeName == UserRoute.name) {
        resolver.next();
      } else {
        resolver.redirect(UserRoute());
      }
    }),
    // add more guards here
  ];
}
