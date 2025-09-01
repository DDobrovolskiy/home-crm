import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_delete_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_event.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/sub/user/event/user_organization_event.dart';
import 'package:home_crm_front/domain/sub/user/repository/user_repository.dart';

import '../../../support/port/port.dart';
import '../../../support/token_service.dart';
import '../event/organization_edit_event.dart';
import '../state/organization_edit_state.dart';
import 'organization_bloc.dart';

class OrganizationEditBloc
    extends Bloc<OrganizationEditEvent, OrganizationEditState> {
  late final OrganizationRepository _organizationRepository = GetIt.instance
      .get<OrganizationRepository>();
  late final UserRepository _userRepository = GetIt.instance
      .get<UserRepository>();
  late final OrganizationBloc _organizationBloc = GetIt.instance
      .get<OrganizationBloc>();
  late final UserOrganizationBloc _userOrganizationBloc = GetIt.instance
      .get<UserOrganizationBloc>();
  late final TokenService _tokenService = GetIt.instance
      .get<TokenService>();

  OrganizationEditBloc() : super(OrganizationEditInitState(success: false)) {
    on<OrganizationEditLoadEvent>((event, emit) async {
      emit.call(OrganizationEditInitState(success: false));
      var token = await _tokenService.getToken(TokenService.organizationToken);
      if (token != null) {
        var organization = await _organizationRepository
            .organizationFromLocalStorage();
        var user = await _userRepository.userFromLocalStorage();
        if (user != null && organization?.owner.id != user.id) {
          emit.call(
            OrganizationEditLoadState(organization: organization, isCan: false),
          );
        } else {
          emit.call(
            OrganizationEditLoadState(organization: organization, isCan: true),
          );
        }
      } else {
        emit.call(OrganizationEditLoadState(organization: null, isCan: true));
      }
    });
    on<OrganizationEditCreateEvent>((event, emit) async {
      var organization = await _organizationRepository.organizationCreate(
        OrganizationCreateDto(name: event.name),
      );
      await _tokenService.saveToken(
          TokenService.organizationToken, organization!.id.toString());
      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
      emit.call(OrganizationEditInitState(success: true));
    });
    on<OrganizationEditUpdateEvent>((event, emit) async {
      await _organizationRepository.organizationUpdate(
        OrganizationUpdateDto(name: event.name, id: event.id),
      );
      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
      emit.call(OrganizationEditInitState(success: true));
    });
    on<OrganizationEditDeleteEvent>((event, emit) async {
      await _organizationRepository.organizationDelete(
          OrganizationDeleteDto(id: event.id));
      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
      emit.call(OrganizationEditInitState(success: true));
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
