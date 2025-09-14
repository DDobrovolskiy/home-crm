// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:home_crm_front/domain/sub/authentication/login_page.dart'
    as _i3;
import 'package:home_crm_front/domain/sub/authentication/registration_page.dart'
    as _i8;
import 'package:home_crm_front/domain/sub/employee/employee_page.dart' as _i1;
import 'package:home_crm_front/domain/sub/home/home_page.dart' as _i2;
import 'package:home_crm_front/domain/sub/organization/organization_employees_page.dart'
    as _i4;
import 'package:home_crm_front/domain/sub/organization/organization_role_page.dart'
    as _i6;
import 'package:home_crm_front/domain/sub/organization/organization_test_page.dart'
    as _i7;
import 'package:home_crm_front/domain/sub/organization/organizations_page.dart'
    as _i5;
import 'package:home_crm_front/domain/sub/role/role_page.dart' as _i9;
import 'package:home_crm_front/domain/sub/user/user_page.dart' as _i10;

/// generated route for
/// [_i1.EmployeePage]
class EmployeeRoute extends _i11.PageRouteInfo<EmployeeRouteArgs> {
  EmployeeRoute({
    _i12.Key? key,
    required int? employeeId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         EmployeeRoute.name,
         args: EmployeeRouteArgs(key: key, employeeId: employeeId),
         rawPathParams: {'employeeId': employeeId},
         initialChildren: children,
       );

  static const String name = 'EmployeeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EmployeeRouteArgs>(
        orElse: () =>
            EmployeeRouteArgs(employeeId: pathParams.optInt('employeeId')),
      );
      return _i1.EmployeePage(key: args.key, employeeId: args.employeeId);
    },
  );
}

class EmployeeRouteArgs {
  const EmployeeRouteArgs({this.key, required this.employeeId});

  final _i12.Key? key;

  final int? employeeId;

  @override
  String toString() {
    return 'EmployeeRouteArgs{key: $key, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.OrganizationEmployeesPage]
class OrganizationEmployeesRoute extends _i11.PageRouteInfo<void> {
  const OrganizationEmployeesRoute({List<_i11.PageRouteInfo>? children})
    : super(OrganizationEmployeesRoute.name, initialChildren: children);

  static const String name = 'OrganizationEmployeesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.OrganizationEmployeesPage();
    },
  );
}

/// generated route for
/// [_i5.OrganizationPage]
class OrganizationRoute extends _i11.PageRouteInfo<void> {
  const OrganizationRoute({List<_i11.PageRouteInfo>? children})
    : super(OrganizationRoute.name, initialChildren: children);

  static const String name = 'OrganizationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.OrganizationPage();
    },
  );
}

/// generated route for
/// [_i6.OrganizationRolesPage]
class OrganizationRolesRoute extends _i11.PageRouteInfo<void> {
  const OrganizationRolesRoute({List<_i11.PageRouteInfo>? children})
    : super(OrganizationRolesRoute.name, initialChildren: children);

  static const String name = 'OrganizationRolesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.OrganizationRolesPage();
    },
  );
}

/// generated route for
/// [_i7.OrganizationTestsPage]
class OrganizationTestsRoute extends _i11.PageRouteInfo<void> {
  const OrganizationTestsRoute({List<_i11.PageRouteInfo>? children})
    : super(OrganizationTestsRoute.name, initialChildren: children);

  static const String name = 'OrganizationTestsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.OrganizationTestsPage();
    },
  );
}

/// generated route for
/// [_i8.RegistrationPage]
class RegistrationRoute extends _i11.PageRouteInfo<void> {
  const RegistrationRoute({List<_i11.PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.RegistrationPage();
    },
  );
}

/// generated route for
/// [_i9.RolePage]
class RoleRoute extends _i11.PageRouteInfo<RoleRouteArgs> {
  RoleRoute({
    _i12.Key? key,
    required int? roleId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         RoleRoute.name,
         args: RoleRouteArgs(key: key, roleId: roleId),
         rawPathParams: {'roleId': roleId},
         initialChildren: children,
       );

  static const String name = 'RoleRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RoleRouteArgs>(
        orElse: () => RoleRouteArgs(roleId: pathParams.optInt('roleId')),
      );
      return _i9.RolePage(key: args.key, roleId: args.roleId);
    },
  );
}

class RoleRouteArgs {
  const RoleRouteArgs({this.key, required this.roleId});

  final _i12.Key? key;

  final int? roleId;

  @override
  String toString() {
    return 'RoleRouteArgs{key: $key, roleId: $roleId}';
  }
}

/// generated route for
/// [_i10.UserPage]
class UserRoute extends _i11.PageRouteInfo<void> {
  const UserRoute({List<_i11.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.UserPage();
    },
  );
}
