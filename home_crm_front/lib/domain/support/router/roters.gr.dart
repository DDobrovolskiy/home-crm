// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:home_crm_front/domain/sub/authentication/login_page.dart'
    as _i4;
import 'package:home_crm_front/domain/sub/authentication/registration_page.dart'
    as _i10;
import 'package:home_crm_front/domain/sub/education/question/question_page.dart'
    as _i9;
import 'package:home_crm_front/domain/sub/education/test/test_page.dart'
    as _i12;
import 'package:home_crm_front/domain/sub/employee/employee_page.dart' as _i1;
import 'package:home_crm_front/domain/sub/employee/employee_test_page.dart'
    as _i2;
import 'package:home_crm_front/domain/sub/home/home_page.dart' as _i3;
import 'package:home_crm_front/domain/sub/organization/organization_employees_page.dart'
    as _i5;
import 'package:home_crm_front/domain/sub/organization/organization_role_page.dart'
    as _i7;
import 'package:home_crm_front/domain/sub/organization/organization_test_page.dart'
    as _i8;
import 'package:home_crm_front/domain/sub/organization/organizations_page.dart'
    as _i6;
import 'package:home_crm_front/domain/sub/role/role_page.dart' as _i11;
import 'package:home_crm_front/domain/sub/user/user_page.dart' as _i13;

/// generated route for
/// [_i1.EmployeePage]
class EmployeeRoute extends _i14.PageRouteInfo<EmployeeRouteArgs> {
  EmployeeRoute({
    _i15.Key? key,
    required int? employeeId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         EmployeeRoute.name,
         args: EmployeeRouteArgs(key: key, employeeId: employeeId),
         rawPathParams: {'employeeId': employeeId},
         initialChildren: children,
       );

  static const String name = 'EmployeeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
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

  final _i15.Key? key;

  final int? employeeId;

  @override
  String toString() {
    return 'EmployeeRouteArgs{key: $key, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i2.EmployeeTestsPage]
class EmployeeTestsRoute extends _i14.PageRouteInfo<void> {
  const EmployeeTestsRoute({List<_i14.PageRouteInfo>? children})
    : super(EmployeeTestsRoute.name, initialChildren: children);

  static const String name = 'EmployeeTestsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.EmployeeTestsPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.OrganizationEmployeesPage]
class OrganizationEmployeesRoute extends _i14.PageRouteInfo<void> {
  const OrganizationEmployeesRoute({List<_i14.PageRouteInfo>? children})
    : super(OrganizationEmployeesRoute.name, initialChildren: children);

  static const String name = 'OrganizationEmployeesRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.OrganizationEmployeesPage();
    },
  );
}

/// generated route for
/// [_i6.OrganizationPage]
class OrganizationRoute extends _i14.PageRouteInfo<void> {
  const OrganizationRoute({List<_i14.PageRouteInfo>? children})
    : super(OrganizationRoute.name, initialChildren: children);

  static const String name = 'OrganizationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.OrganizationPage();
    },
  );
}

/// generated route for
/// [_i7.OrganizationRolesPage]
class OrganizationRolesRoute extends _i14.PageRouteInfo<void> {
  const OrganizationRolesRoute({List<_i14.PageRouteInfo>? children})
    : super(OrganizationRolesRoute.name, initialChildren: children);

  static const String name = 'OrganizationRolesRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.OrganizationRolesPage();
    },
  );
}

/// generated route for
/// [_i8.OrganizationTestsPage]
class OrganizationTestsRoute extends _i14.PageRouteInfo<void> {
  const OrganizationTestsRoute({List<_i14.PageRouteInfo>? children})
    : super(OrganizationTestsRoute.name, initialChildren: children);

  static const String name = 'OrganizationTestsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.OrganizationTestsPage();
    },
  );
}

/// generated route for
/// [_i9.QuestionPage]
class QuestionRoute extends _i14.PageRouteInfo<QuestionRouteArgs> {
  QuestionRoute({
    _i15.Key? key,
    required int testId,
    required int questionId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         QuestionRoute.name,
         args: QuestionRouteArgs(
           key: key,
           testId: testId,
           questionId: questionId,
         ),
         rawPathParams: {'testId': testId, 'questionId': questionId},
         initialChildren: children,
       );

  static const String name = 'QuestionRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<QuestionRouteArgs>(
        orElse: () => QuestionRouteArgs(
          testId: pathParams.getInt('testId'),
          questionId: pathParams.getInt('questionId'),
        ),
      );
      return _i9.QuestionPage(
        key: args.key,
        testId: args.testId,
        questionId: args.questionId,
      );
    },
  );
}

class QuestionRouteArgs {
  const QuestionRouteArgs({
    this.key,
    required this.testId,
    required this.questionId,
  });

  final _i15.Key? key;

  final int testId;

  final int questionId;

  @override
  String toString() {
    return 'QuestionRouteArgs{key: $key, testId: $testId, questionId: $questionId}';
  }
}

/// generated route for
/// [_i10.RegistrationPage]
class RegistrationRoute extends _i14.PageRouteInfo<void> {
  const RegistrationRoute({List<_i14.PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.RegistrationPage();
    },
  );
}

/// generated route for
/// [_i11.RolePage]
class RoleRoute extends _i14.PageRouteInfo<RoleRouteArgs> {
  RoleRoute({
    _i15.Key? key,
    required int? roleId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         RoleRoute.name,
         args: RoleRouteArgs(key: key, roleId: roleId),
         rawPathParams: {'roleId': roleId},
         initialChildren: children,
       );

  static const String name = 'RoleRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RoleRouteArgs>(
        orElse: () => RoleRouteArgs(roleId: pathParams.optInt('roleId')),
      );
      return _i11.RolePage(key: args.key, roleId: args.roleId);
    },
  );
}

class RoleRouteArgs {
  const RoleRouteArgs({this.key, required this.roleId});

  final _i15.Key? key;

  final int? roleId;

  @override
  String toString() {
    return 'RoleRouteArgs{key: $key, roleId: $roleId}';
  }
}

/// generated route for
/// [_i12.TestSuitPage]
class TestSuitRoute extends _i14.PageRouteInfo<TestSuitRouteArgs> {
  TestSuitRoute({
    _i15.Key? key,
    required int testId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         TestSuitRoute.name,
         args: TestSuitRouteArgs(key: key, testId: testId),
         rawPathParams: {'testId': testId},
         initialChildren: children,
       );

  static const String name = 'TestSuitRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TestSuitRouteArgs>(
        orElse: () => TestSuitRouteArgs(testId: pathParams.getInt('testId')),
      );
      return _i12.TestSuitPage(key: args.key, testId: args.testId);
    },
  );
}

class TestSuitRouteArgs {
  const TestSuitRouteArgs({this.key, required this.testId});

  final _i15.Key? key;

  final int testId;

  @override
  String toString() {
    return 'TestSuitRouteArgs{key: $key, testId: $testId}';
  }
}

/// generated route for
/// [_i13.UserPage]
class UserRoute extends _i14.PageRouteInfo<void> {
  const UserRoute({List<_i14.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.UserPage();
    },
  );
}
