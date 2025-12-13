import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../sub/organization/service/organization_service.dart';
import '../../../sub/scope/scope.dart';
import '../../widgets/stamp.dart';

class CheckScope {
  final Function() onTrue;

  const CheckScope({required this.onTrue});

  void checkScope(ScopeType scope, BuildContext? context) {
    if (GetIt.instance.get<OrganizationService>().isEditor(scope)) {
      onTrue();
    } else {
      Stamp.showTemporarySnackbar(
        context,
        'Нет прав: ${ScopeType.ORGANIZATION_UPDATE.description}',
      );
    }
  }
}
