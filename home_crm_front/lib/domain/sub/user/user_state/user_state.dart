import 'package:home_crm_front/domain/sub/user/dto/user_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_employee_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_organization_dto.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadState extends UserState {
  final UserDto? user;
  final UserOrganizationDto? organization;
  final UserEmployeeDto? employee;

  UserLoadState({
    required this.user,
    required this.organization,
    required this.employee,
  });
}

class UserAuthState extends UserState {}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}
