import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/request/simple_auth_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/request/simple_login_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/response/auth_response_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/event/auth_event.dart';
import 'package:home_crm_front/domain/sub/authentication/repository/auth_repository.dart';
import 'package:home_crm_front/domain/sub/authentication/state/auth_state.dart';
import 'package:home_crm_front/domain/support/token_service.dart';

import '../../../support/port/port.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository _repository = GetIt.instance.get<AuthRepository>();
  late final TokenService _tokenService = GetIt.instance.get<TokenService>();

  AuthBloc() : super(AuthCheckState()) {
    on<AuthCheckEvent>((event, emit) async {
      var token = await _tokenService.getToken(TokenService.authToken);
      if (token == null) {
        emit.call(AuthNotLoginState());
      } else {
        var response = await _repository.loginToken();
        await auth(emit, response);
      }
    });
    on<AuthLoginEvent>((event, emit) async {
      var response = await _repository.login(
          SimpleLoginDto(phone: event.phone, password: event.password));
      await auth(emit, response);
    });
    on<AuthRegistrationEvent>((event, emit) async {
      var response = await _repository.registartion(SimpleAuthDto(
        name: event.name,
        phone: event.phone,
        password: event.password,
      ));
      await auth(emit, response);
    });
    on<AuthLogoutEvent>((event, emit) async {
      await _tokenService.clearAllToken();
      emit.call(AuthNotLoginState());
    });
    on<AuthLogoutAllEvent>((event, emit) async {
      await _repository.logout();
      await _tokenService.clearAllToken();
      emit.call(AuthNotLoginState());
    });
    on<AuthErrorEvent>((event, emit) {
      emit.call(AuthLoginErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(AuthErrorEvent(error: e));
    super.onError(error, stackTrace);
  }

  Future<void> auth(
    Emitter<AuthState> emit,
      AuthResponseDto? dto,
  ) async {
    if (dto != null) {
      await _tokenService.saveToken(TokenService.authToken, dto.token);
      await _tokenService.saveToken(
          TokenService.userToken, dto.userId.toString());
      var organizationId = await _tokenService.getToken(
          TokenService.organizationToken);
      if (organizationId != null) {
        //TODO Добавить проверку organizationId, что существует
        emit.call(AuthLoginState(
            userId: dto.userId, organizationId: int.parse(organizationId)));
      } else {
        emit.call(AuthLoginState(userId: dto.userId, organizationId: null));
      }
    } else {
      emit.call(AuthNotLoginState());
    }
  }
}
