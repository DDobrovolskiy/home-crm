import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/event/employee_edit_event.dart';
import 'package:home_crm_front/domain/sub/employee/state/employee_edit_state.dart';

import '../../support/phone.dart';
import '../../support/widgets/stamp.dart';
import '../organization/bloc/organization_role_bloc.dart';
import '../organization/event/organization_role_event.dart';
import '../organization/state/organization_role_state.dart';
import 'bloc/employee_edit_bloc.dart';

@RoutePage()
class EmployeePage extends StatefulWidget {
  const EmployeePage({
    super.key,
    @PathParam("employeeId") required this.employeeId,
  });

  final int? employeeId;

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _password;
  int? _selectedRole;

  final _employeeEditBloc = GetIt.instance.get<EmployeeEditBloc>();
  final _organizationRoleBloc = GetIt.instance.get<OrganizationRoleBloc>();

  @override
  void initState() {
    _employeeEditBloc.add(EmployeeEditLoadEvent(id: widget.employeeId));
    _organizationRoleBloc.add(OrganizationRoleRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeEditBloc, EmployeeEditState>(
      listener: (context, state) {
        if (state.isEndEdit) {
          context.router.back();
        } else if (state.error != null) {
          context.router.back();
        }
      },
      builder: (context, state) {
        if (state.error != null) {
          return SafeArea(
            child: Scaffold(appBar: AppBar(title: Text(state.error!.message))),
          );
        } else {
          return getContent(context, state);
        }
      },
    );
  }

  getContent(BuildContext context, EmployeeEditState state) {
    if (state.isLoading) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Stamp.loadWidget(context)),
          body: Stamp.loadWidget(context),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: state.data == null
                ? Text('Добавление сотрудника')
                : Text('Редактирование сотрудника'),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    fieldEdit(
                      state.data != null,
                      'Имя',
                      state.data?.user.name,
                      (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(height: 5),
                    fieldPhone(
                      state.data != null,
                      'Телефон',
                      state.data?.user.phone,
                      (value) {
                        _phone = value;
                      },
                    ),
                    SizedBox(height: 5),
                    fieldEdit(state.data != null, 'Транспортный пароль', null, (
                      value,
                    ) {
                      _password = value;
                    }),
                    SizedBox(height: 5),
                    BlocBuilder<OrganizationRoleBloc, OrganizationRoleState>(
                      builder: (context, stateOrg) {
                        if (!stateOrg.loaded()) {
                          return Stamp.loadWidget(context);
                        } else {
                          return _roleSelect(
                              context, state.data?.role.id, stateOrg);
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    if (!state.isOnlyWatch)
                      ElevatedButton(
                        child: state.data == null
                            ? Text('Добавить сотрудника')
                            : Text('Обновить сотрудника'),
                        onPressed: () {
                          if (state.data == null) {
                            BlocProvider.of<EmployeeEditBloc>(context).add(
                              EmployeeEditCreateEvent(
                                name: _name!,
                                phone: _phone!,
                                password: _password!,
                                roleId: _selectedRole!,
                              ),
                            );
                          } else {
                            BlocProvider.of<EmployeeEditBloc>(context).add(
                              EmployeeEditUpdateEvent(
                                id: widget.employeeId!,
                                roleId: _selectedRole ?? state.data!.role.id,
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget fieldEdit(
    bool isOnlyWatch,
    String nameVal,
    String? val,
    ValueChanged<String>? onChanged,
  ) {
    if (isOnlyWatch) {
      return Text('$nameVal: $val');
    } else {
      return TextFormField(
        decoration: InputDecoration(labelText: nameVal),
        initialValue: val,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Поле не должно быть пустым';
          }
          return null;
        },
        onChanged: onChanged,
      );
    }
  }

  Widget fieldWatch(String nameVal, String? val) {
    return Text('$nameVal: $val');
  }

  Widget fieldPhone(
    bool isOnlyWatch,
    String nameVal,
    String? val,
    ValueChanged<String>? onChanged,
  ) {
    if (isOnlyWatch) {
      return Text('$nameVal: $val');
    } else {
      return TextFormField(
        inputFormatters: [Phone.phoneFormatter],
        decoration: InputDecoration(
          labelText: nameVal,
          hintText: '+7 (___) ___-__-__',
        ),
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (Phone.isValidPhoneNumber(value)) {
            return null;
          }
          return 'Поле обязательно для заполнения';
        },
        onChanged: onChanged,
      );
    }
  }

  Widget _roleSelect(BuildContext context, int? initRole,
      OrganizationRoleState state) {
    _selectedRole = _selectedRole ?? initRole ??
        state
            .getBody()
            ?.roles
            .first
            .role
            .id;
    return DropdownButton<int>(
      value: _selectedRole,
      // The currently selected value
      hint: const Text('Выберите'),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 8,
      isExpanded: true,
      items: [
        ...?state
            .getBody()
            ?.roles
            .map((role) {
          return DropdownMenuItem<int>(
              value: role.role.id, child: Text(role.role.name));
        }).toList()
      ],
      onChanged: (int? newValue) {
        _selectedRole = newValue;
        setState(() {});
      },
    );
  }
}