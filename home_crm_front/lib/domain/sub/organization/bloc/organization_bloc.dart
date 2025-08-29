import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';

import '../../../support/exceptions/exceptions.dart';
import '../event/organization_event.dart';
import '../state/organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final OrganizationRepository _repository = OrganizationRepository();

  OrganizationBloc() : super(OrganizationInitial()) {
    on<OrganizationLoadEvent>((event, emit) {
      if (event.organization != null) {
        emit.call(OrganizationUpdateState(organization: event.organization!));
      } else {
        emit.call(OrganizationCreateState());
      }
    });
    on<OrganizationCreateEvent>((event, emit) async {
      try {
        var organization = await _repository.organizationCreate(
          OrganizationCreateDto(name: event.name),
        );
        emit.call(OrganizationUpdateState(organization: organization!));
      } catch (e) {
        if (e is AuthException) {
          debugPrint('Ответ сервиса: 401');
          emit.call(OrganizationAuthState());
        } else if (e is PortException) {
          debugPrint('Ошибка сервиса: $e');
          emit.call(OrganizationErrorState(message: 'Ошибка сервера'));
        } else if (e is ResponseException) {
          debugPrint('Ошибка выполнения логики: ${e.message}');
          emit.call(OrganizationErrorState(message: e.message));
        } else {
          debugPrint('Ошибка приложения: $e');
          emit.call(OrganizationErrorState(message: '-'));
        }
      }
    });
    on<OrganizationUpdateEvent>((event, emit) async {
      try {
        var organization = await _repository.organizationUpdate(
          OrganizationUpdateDto(name: event.name, id: event.id),
        );
        emit.call(OrganizationUpdateState(organization: organization!));
      } catch (e) {
        if (e is AuthException) {
          debugPrint('Ответ сервиса: 401');
          emit.call(OrganizationAuthState());
        } else if (e is PortException) {
          debugPrint('Ошибка сервиса: $e');
          emit.call(OrganizationErrorState(message: 'Ошибка сервера'));
        } else if (e is ResponseException) {
          debugPrint('Ошибка выполнения логики: ${e.message}');
          emit.call(OrganizationErrorState(message: e.message));
        } else {
          debugPrint('Ошибка приложения: $e');
          emit.call(OrganizationErrorState(message: '-'));
        }
      }
    });
  }
}
