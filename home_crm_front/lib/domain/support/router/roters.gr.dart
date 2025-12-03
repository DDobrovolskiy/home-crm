// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:home_crm_front/domain/sub/authentication/auth_create_page.dart'
    as _i1;
import 'package:home_crm_front/domain/sub/authentication/auth_login_page.dart'
    as _i2;
import 'package:home_crm_front/domain/sub/education/question/question_page.dart'
    as _i12;
import 'package:home_crm_front/domain/sub/education/test/test_page.dart'
    as _i14;
import 'package:home_crm_front/domain/sub/employee/employee_page.dart' as _i3;
import 'package:home_crm_front/domain/sub/employee/employee_test_page.dart'
    as _i5;
import 'package:home_crm_front/domain/sub/employee/employee_test_run_page.dart'
    as _i4;
import 'package:home_crm_front/domain/sub/home/home_page.dart' as _i6;
import 'package:home_crm_front/domain/sub/news/news_page.dart' as _i7;
import 'package:home_crm_front/domain/sub/organization/organization_employees_page.dart'
    as _i8;
import 'package:home_crm_front/domain/sub/organization/organization_role_page.dart'
    as _i10;
import 'package:home_crm_front/domain/sub/organization/organization_test_page.dart'
    as _i11;
import 'package:home_crm_front/domain/sub/organization/organizations_page.dart'
    as _i9;
import 'package:home_crm_front/domain/sub/role/role_page.dart' as _i13;
import 'package:home_crm_front/domain/sub/user/user_page.dart' as _i15;
import 'package:home_crm_front/domain/sub/user/user_profile_page.dart' as _i16;

/// generated route for
/// [_i1.AuthCreatePage]
class AuthCreateRoute extends _i17.PageRouteInfo<void> {
  const AuthCreateRoute({List<_i17.PageRouteInfo>? children})
    : super(AuthCreateRoute.name, initialChildren: children);

  static const String name = 'AuthCreateRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthCreatePage();
    },
  );
}

/// generated route for
/// [_i2.AuthLoginPage]
class AuthLoginRoute extends _i17.PageRouteInfo<void> {
  const AuthLoginRoute({List<_i17.PageRouteInfo>? children})
    : super(AuthLoginRoute.name, initialChildren: children);

  static const String name = 'AuthLoginRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthLoginPage();
    },
  );
}

/// generated route for
/// [_i3.EmployeePage]
class EmployeeRoute extends _i17.PageRouteInfo<EmployeeRouteArgs> {
  EmployeeRoute({
    _i18.Key? key,
    required int? employeeId,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         EmployeeRoute.name,
         args: EmployeeRouteArgs(key: key, employeeId: employeeId),
         rawPathParams: {'employeeId': employeeId},
         initialChildren: children,
       );

  static const String name = 'EmployeeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EmployeeRouteArgs>(
        orElse: () =>
            EmployeeRouteArgs(employeeId: pathParams.optInt('employeeId')),
      );
      return _i3.EmployeePage(key: args.key, employeeId: args.employeeId);
    },
  );
}

class EmployeeRouteArgs {
  const EmployeeRouteArgs({this.key, required this.employeeId});

  final _i18.Key? key;

  final int? employeeId;

  @override
  String toString() {
    return 'EmployeeRouteArgs{key: $key, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i4.EmployeeTestRunPage]
class EmployeeTestRunRoute
    extends _i17.PageRouteInfo<EmployeeTestRunRouteArgs> {
  EmployeeTestRunRoute({
    _i18.Key? key,
    required int testId,
    required int employeeId,
    List<_i17.PageRouteInfo>? children,
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

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployeeTestRunRouteArgs>();
      return _i4.EmployeeTestRunPage(
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

  final _i18.Key? key;

  final int testId;

  final int employeeId;

  @override
  String toString() {
    return 'EmployeeTestRunRouteArgs{key: $key, testId: $testId, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i5.EmployeeTestsPage]
class EmployeeTestsRoute extends _i17.PageRouteInfo<void> {
  const EmployeeTestsRoute({List<_i17.PageRouteInfo>? children})
    : super(EmployeeTestsRoute.name, initialChildren: children);

  static const String name = 'EmployeeTestsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.EmployeeTestsPage();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.NewsPage]
class NewsRoute extends _i17.PageRouteInfo<void> {
  const NewsRoute({List<_i17.PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.NewsPage();
    },
  );
}

/// generated route for
/// [_i8.OrganizationEmployeesPage]
class OrganizationEmployeesRoute extends _i17.PageRouteInfo<void> {
  const OrganizationEmployeesRoute({List<_i17.PageRouteInfo>? children})
    : super(OrganizationEmployeesRoute.name, initialChildren: children);

  static const String name = 'OrganizationEmployeesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.OrganizationEmployeesPage();
    },
  );
}

/// generated route for
/// [_i9.OrganizationPage]
class OrganizationRoute extends _i17.PageRouteInfo<void> {
  const OrganizationRoute({List<_i17.PageRouteInfo>? children})
    : super(OrganizationRoute.name, initialChildren: children);

  static const String name = 'OrganizationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.OrganizationPage();
    },
  );
}

/// generated route for
/// [_i10.OrganizationRolesPage]
class OrganizationRolesRoute extends _i17.PageRouteInfo<void> {
  const OrganizationRolesRoute({List<_i17.PageRouteInfo>? children})
    : super(OrganizationRolesRoute.name, initialChildren: children);

  static const String name = 'OrganizationRolesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.OrganizationRolesPage();
    },
  );
}

/// generated route for
/// [_i11.OrganizationTestsPage]
class OrganizationTestsRoute extends _i17.PageRouteInfo<void> {
  const OrganizationTestsRoute({List<_i17.PageRouteInfo>? children})
    : super(OrganizationTestsRoute.name, initialChildren: children);

  static const String name = 'OrganizationTestsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.OrganizationTestsPage();
    },
  );
}

/// generated route for
/// [_i12.QuestionPage]
class QuestionRoute extends _i17.PageRouteInfo<QuestionRouteArgs> {
  QuestionRoute({
    _i18.Key? key,
    required int testId,
    required int questionId,
    List<_i17.PageRouteInfo>? children,
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

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<QuestionRouteArgs>(
        orElse: () => QuestionRouteArgs(
          testId: pathParams.getInt('testId'),
          questionId: pathParams.getInt('questionId'),
        ),
      );
      return _i12.QuestionPage(
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

  final _i18.Key? key;

  final int testId;

  final int questionId;

  @override
  String toString() {
    return 'QuestionRouteArgs{key: $key, testId: $testId, questionId: $questionId}';
  }
}

/// generated route for
/// [_i13.RolePage]
class RoleRoute extends _i17.PageRouteInfo<RoleRouteArgs> {
  RoleRoute({
    _i18.Key? key,
    required int? roleId,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         RoleRoute.name,
         args: RoleRouteArgs(key: key, roleId: roleId),
         rawPathParams: {'roleId': roleId},
         initialChildren: children,
       );

  static const String name = 'RoleRoute';

  static _i17.PageInfo page = _i17.PageInfo(
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

  final _i18.Key? key;

  final int? roleId;

  @override
  String toString() {
    return 'RoleRouteArgs{key: $key, roleId: $roleId}';
  }
}

/// generated route for
/// [_i14.TestSuitPage]
class TestSuitRoute extends _i17.PageRouteInfo<TestSuitRouteArgs> {
  TestSuitRoute({
    _i18.Key? key,
    required int testId,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         TestSuitRoute.name,
         args: TestSuitRouteArgs(key: key, testId: testId),
         rawPathParams: {'testId': testId},
         initialChildren: children,
       );

  static const String name = 'TestSuitRoute';

  static _i17.PageInfo page = _i17.PageInfo(
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

  final _i18.Key? key;

  final int testId;

  @override
  String toString() {
    return 'TestSuitRouteArgs{key: $key, testId: $testId}';
  }
}

/// generated route for
/// [_i15.UserPage]
class UserRoute extends _i17.PageRouteInfo<void> {
  const UserRoute({List<_i17.PageRouteInfo>? children})
    : super(UserRoute.name, initialChildren: children);

  static const String name = 'UserRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.UserPage();
    },
  );
}

/// generated route for
/// [_i16.UserProfilePage]
class UserProfileRoute extends _i17.PageRouteInfo<void> {
  const UserProfileRoute({List<_i17.PageRouteInfo>? children})
    : super(UserProfileRoute.name, initialChildren: children);

  static const String name = 'UserProfileRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.UserProfilePage();
    },
  );
}
