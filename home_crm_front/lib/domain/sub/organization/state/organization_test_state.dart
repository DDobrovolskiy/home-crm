import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';
import '../dto/response/organization_test_dto.dart';

abstract class OrganizationTestState {
  static ScopeType scope = ScopeType.TEST_CREATE;
  abstract final bool loaded;
  abstract final OrganizationTestDto? organization;
  abstract final PortException? error;
  abstract final bool hasEdit;
}

class OrganizationTestInitState extends OrganizationTestState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  OrganizationTestDto? get organization => null;

  @override
  bool get hasEdit => false;
}

class OrganizationTestLoadedState extends OrganizationTestState {
  @override
  final OrganizationTestDto? organization;
  @override
  final bool hasEdit;

  OrganizationTestLoadedState({
    required this.organization,
    required this.hasEdit,
  });

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class OrganizationTestErrorState extends OrganizationTestState {
  @override
  final PortException error;

  OrganizationTestErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  OrganizationTestDto? get organization => null;

  @override
  bool get hasEdit => false;
}
