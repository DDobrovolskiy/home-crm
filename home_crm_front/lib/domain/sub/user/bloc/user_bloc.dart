import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/user/repository/user_repository.dart';

import '../../../support/exceptions/exceptions.dart';
import '../event/user_event.dart';
import '../user_state/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<UserLoadEvent>((event, emit) async {
      try {
        var user = await _repository.user();
        var organization = await _repository.organization();
        var employee = await _repository.employee();
        emit.call(
          UserLoadState(
            user: user,
            organization: organization,
            employee: employee,
          ),
        );
      } catch (e) {
        if (e is AuthException) {
          debugPrint('Ответ сервиса: 401');
          emit.call(UserAuthState());
        } else if (e is PortException) {
          debugPrint('Ошибка сервиса: $e');
          emit.call(UserErrorState(message: 'Ошибка сервера'));
        } else if (e is ResponseException) {
          debugPrint('Ошибка выполнения логики: ${e.message}');
          emit.call(UserErrorState(message: e.message));
        } else {
          debugPrint('Ошибка приложения: $e');
          emit.call(UserErrorState(message: '-'));
        }
      }
    });
  }
}
