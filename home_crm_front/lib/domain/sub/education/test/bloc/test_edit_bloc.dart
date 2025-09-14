import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/request/test_update_ready_dto.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../../../../support/port/port.dart';
import '../../../organization/bloc/organization_test_bloc.dart';
import '../../../organization/event/organization_test_event.dart';
import '../../../role/cubit/role_current_scopes.dart';
import '../dto/request/test_create_dto.dart';
import '../dto/request/test_delete_dto.dart';
import '../dto/request/test_update_dto.dart';
import '../event/test_edit_event.dart';
import '../repository/test_repository.dart';
import '../state/test_edit_state.dart';

class TestEditBloc extends Bloc<TestEditEvent, TestEditState> {
  late final TestRepository _testRepository = GetIt.I
      .get<TestRepository>();
  late final OrganizationTestBloc _organizationTestBloc = GetIt.instance
      .get<OrganizationTestBloc>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  TestEditBloc()
    : super(TestEditPointState(isEndEdit: false, isLoading: true)) {
    on<TestEditRefreshEvent>((event, emit) async {
      _organizationTestBloc.add(OrganizationTestRefreshEvent());
      emit.call(TestEditPointState(isEndEdit: true, isLoading: false));
    });
    on<TestEditLoadEvent>((event, emit) async {
      emit.call(TestEditPointState(isEndEdit: false, isLoading: true));
      var bool = await _roleCurrentScopesCubit.checkScopeNoSafe(
        TestEditState.scope,
      );
      if (event.id == null) {
        add(TestEditErrorEvent(error: PortException(
            message: 'Не удалось загрузить тест', auth: false)));
      } else {
        var test = await _testRepository.getTest(event.id!);
        emit.call(TestEditLoadedState(data: test, isOnlyWatch: false));
      }
    });
    on<TestEditCreateEvent>((event, emit) async {
      await _testRepository.create(TestCreateDto(name: event.name));
      add(TestEditRefreshEvent());
    });
    on<TestEditUpdateEvent>((event, emit) async {
      await _testRepository.update(
        TestUpdateDto(
          id: event.id,
          name: event.name,
          timeLimitMinutes: event.timeLimitMinutes,
        ),
      );
      add(TestEditRefreshEvent());
    });
    on<TestEditUpdateReadyEvent>((event, emit) async {
      await _testRepository.updateReady(
        TestUpdateReadyDto(
          id: event.id,
          ready: event.ready,
        ),
      );
      add(TestEditRefreshEvent());
    });
    on<TestEditDeleteEvent>((event, emit) async {
      await _testRepository.delete(TestDeleteDto(id: event.id));
      add(TestEditRefreshEvent());
    });
    on<TestEditErrorEvent>((event, emit) {
      Stamp.showTemporarySnackbar(null, event.error.message);
      emit.call(TestEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(TestEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
