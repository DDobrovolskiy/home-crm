import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/user/repository/user_repository.dart';

import '../../../support/port/port.dart';
import '../event/user_event.dart';
import '../user_state/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late final UserRepository _repository = GetIt.instance.get<UserRepository>();

  UserBloc() : super(UserInitState()) {
    on<UserLoadEvent>((event, emit) async {
      emit.call(UserInitState());
      final user = await _repository.user();
      emit.call(UserLoadedState(user: user));
    });
    on<UserErrorEvent>((event, emit) {
      emit.call(UserErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(UserErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
