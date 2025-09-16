import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';
import '../dto/response/organization_employee_test_dto.dart';

abstract class OrganizationEmployeeTestState {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool loaded;
  abstract final OrganizationEmployeeTestDto? organization;
  abstract final PortException? error;
  abstract final bool hasEdit;
}

class OrganizationEmployeeTestInitState extends OrganizationEmployeeTestState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  OrganizationEmployeeTestDto? get organization => null;

  @override
  bool get hasEdit => false;
}

class OrganizationEmployeeTestLoadedState
    extends OrganizationEmployeeTestState {
  @override
  final OrganizationEmployeeTestDto? organization;
  @override
  final bool hasEdit;

  OrganizationEmployeeTestLoadedState({
    required this.organization,
    required this.hasEdit,
  });

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class OrganizationEmployeeTestErrorState extends OrganizationEmployeeTestState {
  @override
  final PortException error;

  OrganizationEmployeeTestErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  OrganizationEmployeeTestDto? get organization => null;

  @override
  bool get hasEdit => false;
}
