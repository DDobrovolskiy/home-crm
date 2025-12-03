import '../../../support/exceptions/exceptions.dart';
import '../dto/response/organization_selected_dto.dart';

abstract class OrganizationState {}

class OrganizationUnSelectedState extends OrganizationState {}

class OrganizationSelectedState extends OrganizationState {
  final OrganizationSelectedDto selected;

  OrganizationSelectedState({required this.selected});
}

class OrganizationErrorState extends OrganizationState {
  final PortException error;

  OrganizationErrorState({required this.error});
}
