import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/organization_event.dart';
import '../state/organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationBloc() : super(OrganizationInitial()) {
    on<OrganizationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
