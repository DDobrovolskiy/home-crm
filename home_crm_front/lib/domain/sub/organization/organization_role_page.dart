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
import '../role/bloc/role_edit_bloc.dart';
import '../role/event/role_edit_event.dart';
import 'bloc/organization_role_bloc.dart';
import 'event/organization_role_event.dart';
import 'state/organization_role_state.dart';

@RoutePage()
class OrganizationRolesPage extends StatefulWidget {
  const OrganizationRolesPage({super.key});

  @override
  _OrganizationRolesPageState createState() => _OrganizationRolesPageState();
}

class _OrganizationRolesPageState extends State<OrganizationRolesPage> {
  @override
  void initState() {
    BlocProvider.of<OrganizationRoleBloc>(
      context,
    ).add(OrganizationRoleRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationRoleBloc, OrganizationRoleState>(
      listener: (context, state) {
        if (state is OrganizationRoleErrorState) {
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

  Widget getContent(BuildContext context, OrganizationRoleState state) {
    if (!state.loaded) {
      return Stamp.loadWidget(context);
    } else if (state.organization != null) {
      return Column(
        children: [
          for (final role in state.organization!.roles)
            Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.account_box),
                title: Text(role.name),
                subtitle: Row(
                  children: [
                    Text('Описание: ${role.description}'),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        BlocProvider.of<RoleEditBloc>(
                          context,
                        ).add(RoleEditDeleteEvent(id: role.id));
                      },
                    ),
                  ],
                ),
                trailing: OutlinedButton.icon(
                  // Добавили кнопку с иконкой
                  icon: Icon(Icons.edit),
                  label: Text("Редактировать"),
                  onPressed: () {
                    AutoRouter.of(context).push(RoleRoute(roleId: role.id));
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
              title: Text("Добавить роль"),
              onTap: () {
                AutoRouter.of(context).push(RoleRoute(roleId: null));
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
