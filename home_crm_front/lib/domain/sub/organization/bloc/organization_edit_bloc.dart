import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_delete_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_event.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/sub/user/event/user_organization_event.dart';

import '../../../support/port/port.dart';
import '../event/organization_edit_event.dart';
import '../state/organization_edit_state.dart';
import 'organization_bloc.dart';

class OrganizationEditBloc
    extends Bloc<OrganizationEditEvent, OrganizationEditState> {
  late final OrganizationRepository _repository = GetIt.instance
      .get<OrganizationRepository>();
  late final OrganizationBloc _organizationBloc = GetIt.instance
      .get<OrganizationBloc>();
  late final UserOrganizationBloc _userOrganizationBloc = GetIt.instance
      .get<UserOrganizationBloc>();

  OrganizationEditBloc() : super(OrganizationEditInitState()) {
    on<OrganizationEditLoadEvent>((event, emit) {
      if (event.organization != null) {
        emit.call(
          OrganizationEditUpdateState(organization: event.organization!),
        );
      } else {
        emit.call(OrganizationEditCreateState());
      }
    });
    on<OrganizationEditCreateEvent>((event, emit) async {
      await _repository.organizationCreate(
        OrganizationCreateDto(name: event.name),
      );

      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationLoadEvent());

      emit.call(OrganizationEditSuccessState());
    });
    on<OrganizationEditUpdateEvent>((event, emit) async {
      await _repository.organizationUpdate(
        OrganizationUpdateDto(name: event.name, id: event.id),
      );
      _userOrganizationBloc.add(UserOrganizationLoadEvent());
      emit.call(OrganizationEditSuccessState());
    });
    on<OrganizationEditDeleteEvent>((event, emit) async {
      await _repository.organizationDelete(OrganizationDeleteDto(id: event.id));
      _userOrganizationBloc.add(UserOrganizationLoadEvent());
      emit.call(OrganizationEditSuccessState());
    });
    on<OrganizationEditErrorEvent>((event, emit) {
      emit.call(OrganizationEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
