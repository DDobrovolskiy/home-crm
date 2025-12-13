import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../theme/theme.dart';
import '../../../../support/components/button/button.dart';
import '../../../../support/components/dialog/custom_dialog.dart';
import '../../../organization/service/organization_service.dart';
import '../../../scope/scope.dart';
import '../dto/response/test_dto.dart';

class TestDialog extends StatefulWidget {
  static Future<TestDto?> show(BuildContext context, TestDto? test) async {
    return CustomDialog.showDialog<TestDto?>(TestDialog(test: test), context);
  }

  final TestDto? test;

  const TestDialog({super.key, this.test});

  @override
  _TestDialogState createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog> {
  final _formKey = GlobalKey<FormState>();

  bool isCreate() {
    return widget.test == null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
          child: _label(),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Отменить',
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 10),
              CustomButton(
                text: isCreate() ? 'Создать' : 'Обновить',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isCreate()) {
                      // var resul = await GetIt.I
                      //     .get<EmployeeService>()
                      //     .addEmployee(
                      //   EmployeeCreateDto(
                      //     name: _name!,
                      //     phone: _phone!,
                      //     password: _password!,
                      //     roleId: _selectedRole!,
                      //   ),
                      // );
                      Navigator.pop(context);
                    } else {
                      // var resul = await GetIt.I
                      //     .get<EmployeeService>()
                      //     .updateEmployee(
                      //   EmployeeUpdateDto(
                      //     id: _id!,
                      //     roleId: _selectedRole!,
                      //   ),
                      // );
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label() {
    if (isCreate()) {
      return Text(
        'Добавить тест',
        style: CustomColors.getDisplaySmall(context, null),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              'Редактирование теста',
              style: CustomColors.getDisplaySmall(context, null),
            ),
          ),
          if (GetIt.I.get<OrganizationService>().isEditor(
            ScopeType.TEST_CREATE,
          ))
            IconButton(
              onPressed: () async {
                Navigator.pop(context);
                // await GetIt.I.get<EmployeeService>().deleteEmployee(
                //   EmployeeDeleteDto(id: widget.employee!.id),
                // );
              },
              color: CustomColors.getSecondaryText(context),
              icon: Icon(Icons.delete),
            ),
        ],
      );
    }
  }
}
