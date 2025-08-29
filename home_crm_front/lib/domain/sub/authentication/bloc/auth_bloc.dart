import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/simple_auth_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/simple_login_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/event/auth_event.dart';
import 'package:home_crm_front/domain/sub/authentication/repository/auth_repository.dart';
import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';
import 'package:home_crm_front/domain/support/token_service.dart';

import '../../../support/exceptions/exceptions.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthInitEvent>((event, emit) async {
      emit.call(AuthInitial());
    });
    on<AuthLoginEvent>((event, emit) async {
      await auth(
        emit,
        () => _repository.login(
          SimpleLoginDto(phone: event.phone, password: event.password),
        ),
      );
    });
    on<AuthRegistrationEvent>((event, emit) async {
      await auth(
        emit,
        () => _repository.registartion(
          SimpleAuthDto(
            name: event.name,
            phone: event.phone,
            password: event.password,
          ),
        ),
      );
    });
  }

  Future<void> auth(
    Emitter<AuthState> emit,
    Future<String?> Function() responseSupplier,
  ) async {
    emit.call(AuthProcessingState());
    try {
      var token = await responseSupplier();
      if (token != null) {
        await TokenService().saveToken(TokenService.authToken, token!);
        emit.call(AuthSuccessState());
      } else {
        debugPrint('Ответ сервиса при авторизации: token is null');
        emit.call(
          AuthLoginErrorState(
            message: 'Ошибка сервера, повторите попытку позже.',
          ),
        );
      }
    } catch (e) {
      if (e is ResponseException) {
        debugPrint('Ответ сервиса при авторизации: ${e.message}');
        emit.call(AuthLoginErrorState(message: e.message));
      } else if (e is PortException) {
        debugPrint('Ошибка при авторизации: ${e}');
        emit.call(
          AuthLoginErrorState(message: 'Ошибка сети, повторите попытку позже.'),
        );
      }
    }
  }
}
