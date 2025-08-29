import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_delete_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/sub/user/event/user_organization_event.dart';

import '../../../support/port/port.dart';
import '../event/organization_event.dart';
import '../state/organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final OrganizationRepository _repository = OrganizationRepository();
  late final UserOrganizationBloc _userOrganizationBloc = GetIt.instance
      .get<UserOrganizationBloc>();

  OrganizationBloc() : super(OrganizationInitial()) {
    on<OrganizationLoadEvent>((event, emit) {
      if (event.organization != null) {
        emit.call(OrganizationUpdateState(organization: event.organization!));
      } else {
        emit.call(OrganizationCreateState());
      }
    });
    on<OrganizationCreateEvent>((event, emit) async {
      await _repository.organizationCreate(
        OrganizationCreateDto(name: event.name),
      );
      _userOrganizationBloc.add(UserOrganizationLoadEvent());
      emit.call(OrganizationSuccessState());
    });
    on<OrganizationUpdateEvent>((event, emit) async {
      await _repository.organizationUpdate(
        OrganizationUpdateDto(name: event.name, id: event.id),
      );
      _userOrganizationBloc.add(UserOrganizationLoadEvent());
      emit.call(OrganizationSuccessState());
    });
    on<OrganizationDeleteEvent>((event, emit) async {
      await _repository.organizationDelete(OrganizationDeleteDto(id: event.id));
      _userOrganizationBloc.add(UserOrganizationLoadEvent());
      emit.call(OrganizationSuccessState());
    });
    on<OrganizationErrorEvent>((event, emit) {
      emit.call(OrganizationErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
