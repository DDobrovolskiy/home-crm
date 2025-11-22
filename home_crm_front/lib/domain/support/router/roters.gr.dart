// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:home_crm_front/domain/sub/authentication/login_page.dart'
    as _i5;
import 'package:home_crm_front/domain/sub/authentication/registration_page.dart'
as _i12;
import 'package:home_crm_front/domain/sub/education/question/question_page.dart'
    as _i11;
import 'package:home_crm_front/domain/sub/education/test/test_page.dart'
as _i14;
import 'package:home_crm_front/domain/sub/employee/employee_page.dart' as _i1;
import 'package:home_crm_front/domain/sub/employee/employee_test_page.dart'
    as _i3;
import 'package:home_crm_front/domain/sub/employee/employee_test_run_page.dart'
    as _i2;
import 'package:home_crm_front/domain/sub/home/home_page.dart' as _i4;
import 'package:home_crm_front/domain/sub/news/news_page.dart' as _i6;
import 'package:home_crm_front/domain/sub/organization/organization_employees_page.dart'
as _i7;
import 'package:home_crm_front/domain/sub/organization/organization_role_page.dart'
    as _i9;
import 'package:home_crm_front/domain/sub/organization/organization_test_page.dart'
as _i10;
import 'package:home_crm_front/domain/sub/organization/organizations_page.dart'
as _i8;
import 'package:home_crm_front/domain/sub/role/role_page.dart' as _i13;
import 'package:home_crm_front/domain/sub/user/user_page.dart' as _i15;

/// generated route for
/// [_i1.EmployeePage]
class EmployeeRoute extends _i16.PageRouteInfo<EmployeeRouteArgs> {
  EmployeeRoute({
    _i17.Key? key,
    required int? employeeId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         EmployeeRoute.name,
         args: EmployeeRouteArgs(key: key, employeeId: employeeId),
         rawPathParams: {'employeeId': employeeId},
         initialChildren: children,
       );

  static const String name = 'EmployeeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
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

  final _i17.Key? key;

  final int? employeeId;

  @override
  String toString() {
    return 'EmployeeRouteArgs{key: $key, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i2.EmployeeTestRunPage]
class EmployeeTestRunRoute
    extends _i16.PageRouteInfo<EmployeeTestRunRouteArgs> {
  EmployeeTestRunRoute({
    _i17.Key? key,
    required int testId,
    required int employeeId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         EmployeeTestRunRoute.name,
         args: EmployeeTestRunRouteArgs(
           key: key,
           testId: testId,
           employeeId: employeeId,
         ),
         initialChildren: children,
       );

  static const String name = 'EmployeeTestRunRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployeeTestRunRouteArgs>();
      return _i2.EmployeeTestRunPage(
        key: args.key,
        testId: args.testId,
        employeeId: args.employeeId,
      );
    },
  );
}

class EmployeeTestRunRouteArgs {
  const EmployeeTestRunRouteArgs({
    this.key,
    required this.testId,
    required this.employeeId,
  });

  final _i17.Key? key;

  final int testId;

  final int employeeId;

  @override
  String toString() {
    return 'EmployeeTestRunRouteArgs{key: $key, testId: $testId, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i3.EmployeeTestsPage]
class EmployeeTestsRoute extends _i16.PageRouteInfo<void> {
  const EmployeeTestsRoute({List<_i16.PageRouteInfo>? children})
    : super(EmployeeTestsRoute.name, initialChildren: children);

  static const String name = 'EmployeeTestsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i3.EmployeeTestsPage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginPage();
    },
  );
}

/// generated route for
/// [_i6.NewsPage]
class NewsRoute extends _i16.PageRouteInfo<void> {
  const NewsRoute({List<_i16.PageRouteInfo>? children})
      : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.NewsPage();
    },
  );
}

/// generated route for
/// [_i7.OrganizationEmployeesPage]
class OrganizationEmployeesRoute extends _i16.PageRouteInfo<void> {
  const OrganizationEmployeesRoute({List<_i16.PageRouteInfo>? children})
    : super(OrganizationEmployeesRoute.name, initialChildren: children);

  static const String name = 'OrganizationEmployeesRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.OrganizationEmployeesPage();
    },
  );
}

/// generated route for
/// [_i8.OrganizationPage]
class OrganizationRoute extends _i16.PageRouteInfo<void> {
  const OrganizationRoute({List<_i16.PageRouteInfo>? children})
    : super(OrganizationRoute.name, initialChildren: children);

  static const String name = 'OrganizationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i8.OrganizationPage();
    },
  );
}

/// generated route for
/// [_i9.OrganizationRolesPage]
class OrganizationRolesRoute extends _i16.PageRouteInfo<void> {
  const OrganizationRolesRoute({List<_i16.PageRouteInfo>? children})
    : super(OrganizationRolesRoute.name, initialChildren: children);

  static const String name = 'OrganizationRolesRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i9.OrganizationRolesPage();
    },
  );
}

/// generated route for
/// [_i10.OrganizationTestsPage]
class OrganizationTestsRoute extends _i16.PageRouteInfo<void> {
  const OrganizationTestsRoute({List<_i16.PageRouteInfo>? children})
    : super(OrganizationTestsRoute.name, initialChildren: children);

  static const String name = 'OrganizationTestsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i10.OrganizationTestsPage();
    },
  );
}

/// generated route for
/// [_i11.QuestionPage]
class QuestionRoute extends _i16.PageRouteInfo<QuestionRouteArgs> {
  QuestionRoute({
    _i17.Key? key,
    required int testId,
    required int questionId,
    List<_i16.PageRouteInfo>? children,
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

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<QuestionRouteArgs>(
        orElse: () => QuestionRouteArgs(
          testId: pathParams.getInt('testId'),
          questionId: pathParams.getInt('questionId'),
        ),
      );
      return _i11.QuestionPage(
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

  final _i17.Key? key;

  final int testId;

  final int questionId;

  @override
  String toString() {
    return 'QuestionRouteArgs{key: $key, testId: $testId, questionId: $questionId}';
  }
}

/// generated route for
/// [_i12.RegistrationPage]
class RegistrationRoute extends _i16.PageRouteInfo<void> {
  const RegistrationRoute({List<_i16.PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.RegistrationPage();
    },
  );
}

/// generated route for
/// [_i13.RolePage]
class RoleRoute extends _i16.PageRouteInfo<RoleRouteArgs> {
  RoleRoute({
    _i17.Key? key,
    required int? roleId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         RoleRoute.name,
         args: RoleRouteArgs(key: key, roleId: roleId),
         rawPathParams: {'roleId': roleId},
         initialChildren: children,
       );

  static const String name = 'RoleRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RoleRouteArgs>(
        orElse: () => RoleRouteArgs(roleId: pathParams.optInt('roleId')),
      );
      return _i13.RolePage(key: args.key, roleId: args.roleId);
    },
  );
}

class RoleRouteArgs {
  const RoleRouteArgs({this.key, required this.roleId});

  final _i17.Key? key;

  final int? roleId;

  @override
  String toString() {
    return 'RoleRouteArgs{key: $key, roleId: $roleId}';
  }
}

/// generated route for
/// [_i14.TestSuitPage]
class TestSuitRoute extends _i16.PageRouteInfo<TestSuitRouteArgs> {
  TestSuitRoute({
    _i17.Key? key,
    required int testId,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         TestSuitRoute.name,
         args: TestSuitRouteArgs(key: key, testId: testId),
         rawPathParams: {'testId': testId},
         initialChildren: children,
       );

  static const String name = 'TestSuitRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TestSuitRouteArgs>(
        orElse: () => TestSuitRouteArgs(testId: pathParams.getInt('testId')),
      );
      return _i14.TestSuitPage(key: args.key, testId: args.testId);
    },
  );
}

class TestSuitRouteArgs {
  const TestSuitRouteArgs({this.key, required this.testId});

  final _i17.Key? key;

  final int testId;

  @override
  String toString() {
    return 'TestSuitRouteArgs{key: $key, testId: $testId}';
  }
}

/// generated route for
/// [_i15.UserPage]
class UserRoute extends _i16.PageRouteInfo<void> {
  const UserRoute({List<_i16.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.UserPage();
    },
  );
}
