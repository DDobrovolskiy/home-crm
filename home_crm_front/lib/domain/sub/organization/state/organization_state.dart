import '../../../support/exceptions/exceptions.dart';
import '../../../support/service/loaded.dart';
import '../dto/response/organization_selected_dto.dart';

abstract class OrganizationCurrentState
    extends StateLoad<OrganizationSelectedDto> {}

class OrganizationUnSelectedState extends OrganizationCurrentState {
  @override
  OrganizationSelectedDto? getBody() {
    return null;
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

class OrganizationSelectedState extends OrganizationCurrentState {
  final OrganizationSelectedDto selected;

  OrganizationSelectedState({required this.selected});

  @override
  OrganizationSelectedDto? getBody() {
    return selected;
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

class OrganizationErrorState extends OrganizationCurrentState {
  final PortException error;

  OrganizationErrorState({required this.error});

  @override
  OrganizationSelectedDto? getBody() {
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
