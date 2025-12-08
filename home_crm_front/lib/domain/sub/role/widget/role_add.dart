import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/widget/role_dialog.dart';

import '../../../support/components/dialog/custom_dialog.dart';
import '../../scope/dto/response/scope_dto.dart';
import '../dto/response/role_dto.dart';
import '../service/role_service.dart';

class RoleAdd {
  RoleService roleService = GetIt.I.get<RoleService>();

  Future<RoleDto?> build(BuildContext context) async {
    List<ScopeDTO> _allScope = await roleService.getAllScopes() ?? [];
    return CustomDialog.showDialog<RoleDto?>(
      RoleDialog(allScope: _allScope),
      context,
    );
  }
}
