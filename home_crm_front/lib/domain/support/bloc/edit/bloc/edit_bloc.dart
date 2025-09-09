import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../port/port.dart';
import '../event/edit_event.dart';
import '../state/edit_state.dart';

abstract class EditBloc<E, S> extends Bloc<EditEvent<E>, EditState<S>> {
  EditBloc() : super(EditPointState<S>(isEndEdit: false, isLoading: true)) {
    on<EditRefreshEvent<E>>((event, emit) async {
      refreshOtherBloc();
      emit.call(EditPointState(isEndEdit: true, isLoading: false));
    });
    on<EditLoadEvent<E>>((event, emit) async {
      await onLoad(event.data, emit);
    });
    on<EditCreateEvent<E>>((event, emit) async {
      await onCreate(event.data, emit);
      add(EditRefreshEvent());
    });
    on<EditUpdateEvent<E>>((event, emit) async {
      await onUpdate(event.data, emit);
      add(EditRefreshEvent());
    });
    on<EditDeleteEvent<E>>((event, emit) async {
      await onDelete(event.data, emit);
      add(EditRefreshEvent());
    });
    on<EditErrorEvent<E>>((event, emit) {
      emit.call(EditErrorState<S>(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(EditErrorEvent<E>(error: e));
    super.onError(error, stackTrace);
  }

  void refreshOtherBloc();

  Future<void> onLoad(E? data, Emitter<EditState<S>> emit);

  Future<void> onCreate(E? data, Emitter<EditState<S>> emit);

  Future<void> onUpdate(E? data, Emitter<EditState<S>> emit);

  Future<void> onDelete(E? data, Emitter<EditState<S>> emit);
}
