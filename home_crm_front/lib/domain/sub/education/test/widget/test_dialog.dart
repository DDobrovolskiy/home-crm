import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/support/components/label/label_page.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';

import '../../../../../theme/theme.dart';
import '../../../../support/components/callback/NavBarCallBack.dart';
import '../../../../support/components/dialog/custom_dialog.dart';
import '../../../../support/components/tab/custom_tab.dart';
import '../dto/response/test_dto.dart';

class TestDialog extends SheetPage {
  static Future<TestDto?> show(BuildContext context, TestDto? test) async {
    return CustomDialog.showDialog<TestDto?>(TestDialog(test: test), context);
  }

  @override
  String getName() {
    return test == null ? 'Новый тест' : 'Тест Т-${test?.id.toString()}';
  }

  final TestDto? test;

  const TestDialog({super.key, this.test});

  @override
  _TestDialogState createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog> {
  String? _name;
  int? _timeLimitMinutes = 0;

  bool isCreate() {
    return widget.test == null;
  }

  @override
  Widget build(BuildContext context) {
    return DialogPage(
      label: (validator) {
        return Column(
          children: [
            LabelPage(
              text: widget.getName(),
              onButton: () async {
                if (validator()) {
                  GetIt.I.get<SheetElementDeleteCallback>().call(
                    widget.getName(),
                  );
                }
                // if (_formKey.currentState!.validate()) {
                //   if (isCreate()) {
                //     // var resul = await GetIt.I
                //     //     .get<EmployeeService>()
                //     //     .addEmployee(
                //     //   EmployeeCreateDto(
                //     //     name: _name!,
                //     //     phone: _phone!,
                //     //     password: _password!,
                //     //     roleId: _selectedRole!,
                //     //   ),
                //     // );
                //   } else {
                //     // var resul = await GetIt.I
                //     //     .get<EmployeeService>()
                //     //     .updateEmployee(
                //     //   EmployeeUpdateDto(
                //     //     id: _id!,
                //     //     roleId: _selectedRole!,
                //     //   ),
                //     // );
                //   }
                //
                // }
              },
              buttonText: 'Сохранить и закрыть',
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 12),
              child: Row(
                children: [
                  Text('Тест готов: '),
                  Checkbox(value: false, onChanged: (bool? value) {}),
                ],
              ),
            ),
          ],
        );
      },
      contents: [
        (key) => CustomTabView(name: 'Основное', child: main(key)),
        (key) => CustomTabView(name: 'Вопросы', child: main(key)),
      ],
    );
  }

  Widget main(GlobalKey<FormState> _formKeyTab) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 16, 2, 2),
      child: Form(
        key: _formKeyTab,
        autovalidateMode: AutovalidateMode.disabled,
        child: Row(
          children: [
            Expanded(
              child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
              child: TextFormField(
                decoration: CustomColors.getTextFormInputDecoration(
                    'Название теста *',
                    null,
                  context,
                    true,
                  ),
                  // style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                      return 'Необходимо ввести название теста';
                    }
                  return null;
                },
                onChanged: (value) => _name = value,
              ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
              child: TextFormField(
                decoration: CustomColors.getTextFormInputDecoration(
                    'Время выполнениния в минутах (0 - без ограничений) *',
                    null,
                  context,
                    true,
                  ),
                  // style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _timeLimitMinutes.toString(),
                  validator: (value) {
                    if (value == null || RegExp(r'\d{4}').hasMatch(value)) {
                      return 'Необходимо ввести выполнениния в минутах';
                    }
                  return null;
                },
                  onChanged: (value) =>
                      _timeLimitMinutes = int.tryParse(value) ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
