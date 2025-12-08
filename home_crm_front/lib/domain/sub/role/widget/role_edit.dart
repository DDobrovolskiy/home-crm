import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/role/widget/role_dialog.dart';

import '../../../support/components/dialog/custom_dialog.dart';
import '../dto/response/role_dto.dart';
import '../dto/response/role_full_dto.dart';

class RoleEdit {
  Future<RoleDto?> edit(BuildContext context, RoleFullDto role) async {
    return CustomDialog.showDialog<RoleDto?>(RoleDialog(role: role), context);
  }
}
