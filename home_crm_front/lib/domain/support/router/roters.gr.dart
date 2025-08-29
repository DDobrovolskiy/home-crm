// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:home_crm_front/domain/sub/authentication/login_page.dart'
    as _i2;
import 'package:home_crm_front/domain/sub/authentication/registration_page.dart'
    as _i4;
import 'package:home_crm_front/domain/sub/home/home_page.dart' as _i1;
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart'
    as _i8;
import 'package:home_crm_front/domain/sub/organization/organizations_page.dart'
    as _i3;
import 'package:home_crm_front/domain/sub/user/user_page.dart' as _i5;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.OrganizationPage]
class OrganizationRoute extends _i6.PageRouteInfo<OrganizationRouteArgs> {
  OrganizationRoute({
    _i7.Key? key,
    required _i8.OrganizationDto organization,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         OrganizationRoute.name,
         args: OrganizationRouteArgs(key: key, organization: organization),
         initialChildren: children,
       );

  static const String name = 'OrganizationRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrganizationRouteArgs>();
      return _i3.OrganizationPage(
        key: args.key,
        organization: args.organization,
      );
    },
  );
}

class OrganizationRouteArgs {
  const OrganizationRouteArgs({this.key, required this.organization});

  final _i7.Key? key;

  final _i8.OrganizationDto organization;

  @override
  String toString() {
    return 'OrganizationRouteArgs{key: $key, organization: $organization}';
  }
}

/// generated route for
/// [_i4.RegistrationPage]
class RegistrationRoute extends _i6.PageRouteInfo<void> {
  const RegistrationRoute({List<_i6.PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.RegistrationPage();
    },
  );
}

/// generated route for
/// [_i5.UserPage]
class UserRoute extends _i6.PageRouteInfo<void> {
  const UserRoute({List<_i6.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.UserPage();
    },
  );
}
