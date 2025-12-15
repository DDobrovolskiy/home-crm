import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_role_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../../support/components/dialog/custom_dialog.dart';
import '../../../support/phone.dart';
import '../../../support/service/loaded.dart';
import '../../../support/widgets/stamp.dart';
import '../../organization/dto/response/organization_role_dto.dart';
import '../../organization/service/organization_service.dart';
import '../../organization/state/organization_role_state.dart';
import '../../scope/scope.dart';
import '../dto/request/employee_create_dto.dart';
import '../dto/request/employee_delete_dto.dart';
import '../dto/request/employee_update_dto.dart';
import '../dto/response/employee_dto.dart';
import '../service/employee_service.dart';

class EmployeeDialog extends StatefulWidget {
  static Future<EmployeeDto?> show(
    BuildContext context,
    EmployeeDto? employee,
  ) async {
    return CustomDialog.showDialog<EmployeeDto?>(
      EmployeeDialog(employee: employee),
      context,
    );
  }

  final EmployeeDto? employee;

  const EmployeeDialog({super.key, this.employee});

  @override
  _EmployeeDialogState createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  String? _name;
  String? _phone;
  String? _password;
  int? _selectedRole;

  @override
  void initState() {
    GetIt.instance.get<OrganizationService>().refreshOrganizationRoles(
      Loaded.ifNotLoad,
    );
    _id = widget.employee?.id;
    _selectedRole = widget.employee?.role.id;
    super.initState();
  }

  bool isCreate() {
    return widget.employee == null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationRoleBloc, OrganizationRoleState>(
      listener: (context, state) {
        if (state.getError() != null) {
          Stamp.showTemporarySnackbar(context, state.getError()!.message);
        }
      },
      builder: (context, state) {
        if (!state.loaded()) {
          return Stamp.loadWidget(context);
        } else if (state.getBody() != null) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                child: _label(),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    if (isCreate())
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                        child: TextFormField(
                          decoration: CustomColors.getTextFormInputDecoration(
                            'Имя сотрудника',
                            null,
                            context,
                              true
                          ),
                          style: CustomColors.getBodyMedium(context, null),
                          maxLines: null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _name,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Необходимо ввести имя сотрудника';
                            }
                            return null;
                          },
                          onChanged: (value) => _name = value,
                        ),
                      ),
                    if (isCreate())
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                        child: TextFormField(
                          inputFormatters: [Phone.phoneFormatter],
                          decoration: CustomColors.getTextFormInputDecoration(
                            'Телефон',
                            '+7 (___) ___-__-__',
                            context,
                              true
                          ),
                          style: CustomColors.getBodyMedium(context, null),
                          maxLines: null,
                          keyboardType: TextInputType.phone,
                          initialValue: _phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (Phone.isValidPhoneNumber(value)) {
                              return null;
                            }
                            return 'Необходимо ввести номер телефона сотрудника';
                          },
                          onChanged: (value) => _phone = value,
                        ),
                      ),
                    if (isCreate())
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                        child: TextFormField(
                          decoration: CustomColors.getTextFormInputDecoration(
                            'Транспортный пароль',
                            null,
                            context,
                              true
                          ),
                          style: CustomColors.getBodyMedium(context, null),
                          maxLines: null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _password,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Необходимо ввести транспортный пароль';
                            }
                            return null;
                          },
                          onChanged: (value) => _password = value,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                      child: _roleSelect2(state.getBody()!),
                    ),
                  ],
                ),
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
                            var resul = await GetIt.I
                                .get<EmployeeService>()
                                .addEmployee(
                                  EmployeeCreateDto(
                                    name: _name!,
                                    phone: _phone!,
                                    password: _password!,
                                    roleId: _selectedRole!,
                                  ),
                                );
                            Navigator.pop(context, resul);
                          } else {
                            var resul = await GetIt.I
                                .get<EmployeeService>()
                                .updateEmployee(
                                  EmployeeUpdateDto(
                                    id: _id!,
                                    roleId: _selectedRole!,
                                  ),
                                );
                            Navigator.pop(context, resul);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget _roleSelect2(OrganizationRoleDto role) {
    // https://pub.dev/documentation/dropdown_button2/latest/
    return DropdownButtonFormField2<int>(
      value: _selectedRole,
      isExpanded: true,
      decoration: CustomColors.getTextFormInputDecoration(
        'Роль сотрудника',
        null,
        context,
          true
      ),
      items: [
        ...role.roles
            .where((role) {
              return !role.role.owner;
            })
            .map((role) {
              return DropdownMenuItem<int>(
                value: role.role.id,
                child: Text(
                  role.role.name,
                  style: CustomColors.getLabelMedium(context, null),
                ),
              );
            }),
      ],
      validator: (value) {
        if (value == null) {
          return 'Необходимо выбрать роль сотруднику';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      onSaved: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      buttonStyleData: ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: CustomColors.getSecondaryText(context),
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColors.getPrimaryBackground(context),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _label() {
    if (isCreate()) {
      return Text(
        'Добавить сотрудника',
        style: CustomColors.getDisplaySmall(context, null),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              'Редактирование сотрудника',
              style: CustomColors.getDisplaySmall(context, null),
            ),
          ),
          if (!widget.employee!.role.owner &&
              GetIt.I.get<OrganizationService>().isEditor(
                ScopeType.ORGANIZATION_UPDATE,
              ))
            IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await GetIt.I.get<EmployeeService>().deleteEmployee(
                  EmployeeDeleteDto(id: widget.employee!.id),
                );
              },
              color: CustomColors.getSecondaryText(context),
              icon: Icon(Icons.delete),
            ),
        ],
      );
    }
  }
}
