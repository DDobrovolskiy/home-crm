import '../../../exceptions/exceptions.dart';

abstract class EditEvent<T> {
  abstract final T? data;
}

class EditRefreshEvent<T> extends EditEvent<T> {
  @override
  T? get data => null;
}

class EditLoadEvent<T> extends EditEvent<T> {
  @override
  final T? data;

  EditLoadEvent({required this.data});
}

class EditCreateEvent<T> extends EditEvent<T> {
  @override
  final T? data;

  EditCreateEvent({required this.data});
}

class EditUpdateEvent<T> extends EditEvent<T> {
  @override
  final T? data;

  EditUpdateEvent({required this.data});
}

class EditDeleteEvent<T> extends EditEvent<T> {
  @override
  final T? data;

  EditDeleteEvent({required this.data});
}

class EditErrorEvent<T> extends EditEvent<T> {
  final PortException error;

  EditErrorEvent({required this.error});

  @override
  T? get data => null;
}
