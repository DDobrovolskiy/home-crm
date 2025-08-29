import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_employee_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_organization_dto.dart';

abstract class UserState {}

class UserInitial extends UserState {
  String tets = '';
}

class UserLoadState extends UserState {
  UserDto? user;
  UserOrganizationDto? organization;
  UserEmployeeDto? employee;

  UserLoadState({
    required this.user,
    required this.organization,
    required this.employee,
  });
}

class UserAuthState extends UserState implements AuthState {}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}
