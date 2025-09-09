import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/bloc/employee_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/event/employee_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../support/widgets/stamp.dart';

@RoutePage()
class OrganizationEmployeesPage extends StatefulWidget {
  const OrganizationEmployeesPage({super.key});

  @override
  _OrganizationEmployeesPageState createState() =>
      _OrganizationEmployeesPageState();
}

class _OrganizationEmployeesPageState extends State<OrganizationEmployeesPage> {
  @override
  void initState() {
    BlocProvider.of<OrganizationEmployeeBloc>(
      context,
    ).add(OrganizationEmployeeRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationEmployeeBloc, OrganizationEmployeeState>(
      listener: (context, state) {
        if (state is OrganizationEmployeeErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text('Работники в организации')),
            body: getContent(context, state),
          ),
        );
      },
    );
  }

  Widget getContent(BuildContext context, OrganizationEmployeeState state) {
    if (!state.loaded) {
      return Stamp.loadWidget(context);
    } else if (state.organization != null) {
      return Column(
        children: [
          for (final empOrg in state.organization!.employees)
            Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.face),
                title: Text(empOrg.user.name),
                subtitle: Row(
                  children: [
                    Text('Роль: '),
                    TextButton(
                      style: Stamp.giperLink(),
                      child: Text('${empOrg.role.name}'),
                      onPressed: () {
                        //
                      },
                    ),
                    Text('Описание: ${empOrg.role.description}'),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        BlocProvider.of<EmployeeEditBloc>(
                          context,
                        ).add(EmployeeEditDeleteEvent(id: empOrg.id));
                      },
                    ),
                  ],
                ),
                trailing: OutlinedButton.icon(
                  // Добавили кнопку с иконкой
                  icon: Icon(Icons.keyboard_arrow_right),
                  label: Text("Выбрать"),
                  onPressed: () {
                    AutoRouter.of(context).push(
                        EmployeeRoute(employeeId: empOrg.id));
                  },
                ),
              ),
            ),
          // Кнопка добавления новой организации-владельца
          Card(
            color: Colors.blue.shade100,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Добавить сотрудника"),
              onTap: () {
                AutoRouter.of(context).push(EmployeeRoute(employeeId: null));
              },
            ),
          ),
        ],
      );
    } else {
      return Stamp.errorWidget(context);
    }
  }
}
