import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../support/port/port.dart';
import '../event/user_organization_event.dart';
import '../repository/user_repository.dart';
import '../user_state/user_organization_state.dart';

class UserOrganizationBloc
    extends Bloc<UserOrganizationEvent, UserOrganizationState> {
  final UserRepository _repository = UserRepository();

  UserOrganizationBloc() : super(UserOrganizationInitState()) {
    on<UserOrganizationLoadEvent>((event, emit) async {
      emit.call(UserOrganizationInitState());
      final organization = await _repository.organization();
      emit.call(UserOrganizationLoadedState(organization: organization));
    });
    on<UserOrganizationErrorEvent>((event, emit) {
      emit.call(UserOrganizationErrorState(error: event.error));
    });
    add(UserOrganizationLoadEvent());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(UserOrganizationErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
