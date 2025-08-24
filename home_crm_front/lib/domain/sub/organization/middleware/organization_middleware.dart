import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_delete_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:redux/redux.dart';

import '../../../support/port/port.dart';
import '../../../support/redux/state/app_state.dart';
import '../../../support/router/roters.dart';
import '../../user/actions/user_actions.dart';
import '../actions/organization_actions.dart';

class OrganizationMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is OrganizationCreateAction) {
      Port.post(
        'organization',
        OrganizationCreateDto(name: action.name).toJson(),
        store,
        (j) => OrganizationDto.fromJson(j as Map<String, dynamic>),
        (organization) {
          store.dispatch(RefreshInfoUserAction());
        },
      );
    } else if (action is OrganizationDeleteAction) {
      Port.delete(
        'organization',
        OrganizationDeleteDto(id: action.id).toJson(),
        store,
        (j) => j,
        (data) {
          store.dispatch(RefreshInfoUserAction());
        },
      );
    } else if (action is OrganizationInitUpdateAction) {
      store.state.userState?.setOrganizationInitUpdate(action.org);
      store.dispatch(NavigateToAction.replace(RoutersApp.organization));
    } else if (action is OrganizationNotUpdateAction) {
      store.state.userState?.setOrganizationInitUpdate(null);
    } else if (action is OrganizationUpdateAction) {
      store.dispatch(OrganizationNotUpdateAction());
      Port.put(
        'organization',
        OrganizationUpdateDto(id: action.id, name: action.name).toJson(),
        store,
        (j) => j,
        (data) {
          store.dispatch(RefreshInfoUserAction());
        },
      );
    } else {
      next(action);
    }
  }
}
