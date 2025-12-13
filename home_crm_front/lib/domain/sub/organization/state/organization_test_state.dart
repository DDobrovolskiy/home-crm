import '../../../support/exceptions/exceptions.dart';
import '../../../support/service/loaded.dart';
import '../dto/response/organization_test_dto.dart';

abstract class OrganizationTestState extends StateLoad<OrganizationTestDto> {}

class OrganizationTestInitState extends OrganizationTestState {
  @override
  OrganizationTestDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return false;
  }
}

class OrganizationTestLoadedState extends OrganizationTestState {
  final OrganizationTestDto? organization;

  OrganizationTestLoadedState({
    required this.organization,
  });

  @override
  OrganizationTestDto? getBody() {
    return organization;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return true;
  }
}

class OrganizationTestErrorState extends OrganizationTestState {
  final PortException error;

  OrganizationTestErrorState({required this.error});

  @override
  OrganizationTestDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return true;
  }
}
