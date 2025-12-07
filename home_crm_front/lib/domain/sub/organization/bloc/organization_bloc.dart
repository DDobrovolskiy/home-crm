import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';
import 'package:home_crm_front/domain/support/token_service.dart';

import '../../../support/port/port.dart';
import '../event/organization_event.dart';
import '../state/organization_state.dart';

class OrganizationCurrentBloc
    extends Bloc<OrganizationCurrentEvent, OrganizationCurrentState> {
  late final OrganizationRepository _repository = GetIt.instance
      .get<OrganizationRepository>();
  late final TokenService _tokenService = GetIt.instance
      .get<TokenService>();

  OrganizationCurrentBloc() : super(OrganizationUnSelectedState()) {
    on<OrganizationRefreshEvent>((event, emit) async {
      refresh();
    });
    on<OrganizationUnSelectedEvent>((event, emit) async {
      await _tokenService.clearToken(
          TokenService.organizationToken);
      add(OrganizationRefreshEvent());
    });
    on<OrganizationSelectedEvent>((event, emit) async {
      await _tokenService.saveToken(
          TokenService.organizationToken, event.id.toString());
      add(OrganizationRefreshEvent());
    });
    on<OrganizationErrorEvent>((event, emit) async {
      await _tokenService.clearToken(TokenService.organizationToken);
      add(OrganizationRefreshEvent());
    });
  }

  void refresh() async {
    // emit.call(OrganizationUnSelectedState());
    var token = await _tokenService.getToken(TokenService.organizationToken);
    if (token == null) {
      emit.call(OrganizationUnSelectedState());
    } else {
      var organization = await _repository.organization();
      if (organization != null) {
        emit.call(OrganizationSelectedState(selected: organization));
      } else {
        emit.call(OrganizationUnSelectedState());
      }
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
