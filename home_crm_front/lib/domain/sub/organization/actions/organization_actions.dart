import 'package:home_crm_front/domain/sub/organization/store/organization_state.dart';

class OrganizationCreateAction {
  final String name;

  OrganizationCreateAction({required this.name});
}

class OrganizationDeleteAction {
  final int id;

  OrganizationDeleteAction({required this.id});
}

class OrganizationInitUpdateAction {
  final OrganizationState org;

  OrganizationInitUpdateAction({required this.org});
}

class OrganizationNotUpdateAction {}

class OrganizationUpdateAction {
  final int id;
  final String name;

  OrganizationUpdateAction({required this.id, required this.name});
}
