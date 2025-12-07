import '../../../support/exceptions/exceptions.dart';
import '../dto/response/organization_selected_dto.dart';

abstract class OrganizationCurrentState {}

class OrganizationUnSelectedState extends OrganizationCurrentState {}

class OrganizationSelectedState extends OrganizationCurrentState {
  final OrganizationSelectedDto selected;

  OrganizationSelectedState({required this.selected});
}

class OrganizationErrorState extends OrganizationCurrentState {
  final PortException error;

  OrganizationErrorState({required this.error});
}
