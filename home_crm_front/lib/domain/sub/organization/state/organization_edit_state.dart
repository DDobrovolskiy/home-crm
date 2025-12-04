import 'package:equatable/equatable.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class OrganizationEditState extends Equatable {
  abstract final bool loaded;
  abstract final bool isCan;
  abstract final bool success;
  abstract final OrganizationDto? organization;
  abstract final PortException? error;

  @override
  List<Object> get props => [loaded, isCan, success, ?organization, ?error];
}

class OrganizationEditInitState extends OrganizationEditState {
  @override
  final bool success;
  @override
  final OrganizationDto? organization;

  OrganizationEditInitState(
      {required this.success, required this.organization});

  @override
  bool get loaded => true;

  @override
  bool get isCan => false;

  @override
  PortException? get error => null;
}

class OrganizationEditLoadState extends OrganizationEditState {
  @override
  final OrganizationDto? organization;
  @override
  final bool isCan;

  OrganizationEditLoadState({required this.organization, required this.isCan});

  @override
  bool get success => false;

  @override
  bool get loaded => false;

  @override
  PortException? get error => null;
}

class OrganizationEditErrorState extends OrganizationEditState {
  @override
  final PortException error;

  OrganizationEditErrorState({required this.error});

  @override
  bool get loaded => false;

  @override
  bool get isCan => false;

  @override
  bool get success => false;

  @override
  OrganizationDto? get organization => null;
}

