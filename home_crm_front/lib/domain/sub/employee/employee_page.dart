import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/event/employee_edit_event.dart';
import 'package:home_crm_front/domain/support/bloc/edit/event/edit_event.dart';
import 'package:home_crm_front/domain/support/bloc/edit/state/edit_state.dart';

import '../../support/phone.dart';
import '../../support/widgets/stamp.dart';
import 'bloc/employee_edit_bloc.dart';
import 'dto/response/employee_dto.dart';

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

  final _employeeEditBloc = GetIt.instance.get<EmployeeEditBloc>();

  @override
  void initState() {
    _employeeEditBloc.add(
      EditLoadEvent(data: EmployeeEditEvent(id: widget.employeeId)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeEditBloc, EditState<EmployeeDto>>(
      listener: (context, state) {
        if (state.isEndEdit) {
          context.router.back();
        } else if (state.error != null) {
          Stamp.showTemporarySnackbar(context, state.error!.message);
        }
      },
      builder: (context, state) {
        return getContent(context, state);
      },
    );
  }

  getContent(BuildContext context, EditState<EmployeeDto> state) {
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
                    fieldEdit(
                      state.data != null,
                      'Имя',
                      state.data?.user.name,
                          (value) {
                        _name = value;
                      },
                    ),
                    fieldPhone(
                      state.data != null,
                      'Телефон',
                      state.data?.user.phone,
                          (value) {
                        _phone = value;
                      },
                    ),
                    fieldEdit(
                      state.data != null,
                      'Транспортный пароль',
                      null,
                          (value) {
                        _password = value;
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
                                EditCreateEvent(data: EmployeeEditEvent(
                                    name: _name,
                                    phone: _phone,
                                    password: _password))
                            );
                          } else {
                            // BlocProvider.of<EmployeeEditBloc>(context).add(
                            //   OrganizationEditUpdateEvent(
                            //     id: state.organization!.id,
                            //     name:
                            //     _organizationName ??
                            //         state.organization!.name,
                            //   ),
                            // );
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

  Widget fieldEdit(bool isOnlyWatch,
      String nameVal,
      String? val,
      ValueChanged<String>? onChanged,) {
    if (isOnlyWatch) {
      return Text('$nameVal: $val');
    } else {
      return TextFormField(
        decoration: InputDecoration(labelText: nameVal),
        initialValue: val,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value
              .trim()
              .isEmpty) {
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

  Widget fieldPhone(bool isOnlyWatch,
      String nameVal,
      String? val,
      ValueChanged<String>? onChanged,) {
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
