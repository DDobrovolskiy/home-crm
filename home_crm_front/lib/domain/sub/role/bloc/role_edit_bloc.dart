import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/scope/repository/scope_repository.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../../../support/port/port.dart';
import '../../organization/bloc/organization_role_bloc.dart';
import '../../organization/event/organization_role_event.dart';
import '../dto/request/role_create_dto.dart';
import '../dto/request/role_delete_dto.dart';
import '../dto/request/role_update_dto.dart';
import '../event/role_edit_event.dart';
import '../repository/role_repository.dart';
import '../state/role_edit_state.dart';

class RoleEditBloc extends Bloc<RoleEditEvent, RoleEditState> {
  late final RoleRepository _roleRepository = GetIt.instance
      .get<RoleRepository>();
  late final OrganizationRoleBloc _organizationRoleBloc = GetIt.instance
      .get<OrganizationRoleBloc>();
  late final ScopeRepository _scopeRepository = GetIt.instance
      .get<ScopeRepository>();

  RoleEditBloc()
    : super(RoleEditPointState(isEndEdit: false, isLoading: true)) {
    on<RoleEditRefreshEvent>((event, emit) async {
      _organizationRoleBloc.add(OrganizationRoleRefreshEvent());
      emit.call(RoleEditPointState(isEndEdit: true, isLoading: false));
    });
    on<RoleEditLoadEvent>((event, emit) async {
      emit.call(RoleEditPointState(isEndEdit: false, isLoading: true));
        var scopes = await _scopeRepository.scopes();
        if (event.id == null) {
          emit.call(
            RoleEditLoadedState(
              data: null,
              isOnlyWatch: false,
              scopes: scopes ?? [],
              roleScope: null,
            ),
          );
        } else {
          var role = await _roleRepository.role(event.id!);
          var roleScope = await _roleRepository.roleScopes(event.id!);
          emit.call(
            RoleEditLoadedState(
              data: role,
              isOnlyWatch: false,
              scopes: scopes ?? [],
              roleScope: roleScope,
            ),
          );
        }
    });
    on<RoleEditCreateEvent>((event, emit) async {
      await _roleRepository.roleCreate(
        RoleCreateDto(
          name: event.name,
          description: event.description,
          scopes: event.scopes,
        ),
      );
      add(RoleEditRefreshEvent());
    });
    on<RoleEditUpdateEvent>((event, emit) async {
      await _roleRepository.roleUpdate(
        RoleUpdateDto(
          id: event.id,
          name: event.name,
          description: event.description,
          scopes: event.scopes,
        ),
      );
      add(RoleEditRefreshEvent());
    });
    on<RoleEditDeleteEvent>((event, emit) async {
      await _roleRepository.roleDelete(RoleDeleteDto(id: event.id));
      add(RoleEditRefreshEvent());
    });
    on<RoleEditErrorEvent>((event, emit) {
      Stamp.showTemporarySnackbar(null, event.error.message);
      emit.call(RoleEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(RoleEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
