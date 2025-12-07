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
import '../../user/bloc/user_employee_bloc.dart';
import '../../user/event/user_employee_event.dart';
import '../event/organization_edit_event.dart';
import '../state/organization_edit_state.dart';
import 'organization_bloc.dart';

class OrganizationEditBloc
    extends Bloc<OrganizationEditEvent, OrganizationEditState> {
  late final OrganizationRepository _organizationRepository = GetIt.instance
      .get<OrganizationRepository>();
  late final UserRepository _userRepository = GetIt.instance
      .get<UserRepository>();
  late final OrganizationCurrentBloc _organizationBloc = GetIt.instance
      .get<OrganizationCurrentBloc>();
  late final UserOrganizationBloc _userOrganizationBloc = GetIt.instance
      .get<UserOrganizationBloc>();
  late final UserEmployeeBloc _userEmployeeBloc = GetIt.instance
      .get<UserEmployeeBloc>();
  late final TokenService _tokenService = GetIt.instance.get<TokenService>();

  OrganizationEditBloc()
    : super(OrganizationEditInitState(success: false, organization: null)) {
    on<OrganizationEditLoadEvent>((event, emit) async {
      emit.call(OrganizationEditInitState(success: false, organization: null));
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
        TokenService.organizationToken,
        organization!.id.toString(),
      );
      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
      _userEmployeeBloc.add(UserEmployeeLoadEvent());
      emit.call(
        OrganizationEditInitState(success: true, organization: organization),
      );
    });
    on<OrganizationEditUpdateEvent>((event, emit) async {
      var organization = await _organizationRepository.organizationUpdate(
        OrganizationUpdateDto(name: event.name, id: event.id),
      );
      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
      _userEmployeeBloc.add(UserEmployeeLoadEvent());
      emit.call(
        OrganizationEditInitState(success: true, organization: organization),
      );
    });
    on<OrganizationEditDeleteEvent>((event, emit) async {
      var token = await _tokenService.getToken(TokenService.organizationToken);
      if (token != null && event.id == int.parse(token)) {
        await _tokenService.clearToken(TokenService.organizationToken);
      }
      await _organizationRepository.organizationDelete(
        OrganizationDeleteDto(id: event.id),
      );
      _organizationBloc.add(OrganizationRefreshEvent());
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
      _userEmployeeBloc.add(UserEmployeeLoadEvent());
      emit.call(OrganizationEditInitState(success: true, organization: null));
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
