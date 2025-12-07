import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_event.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/sub/user/event/user_employee_event.dart';
import 'package:home_crm_front/domain/sub/user/event/user_event.dart';
import 'package:home_crm_front/domain/sub/user/event/user_organization_event.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_employee_state.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_organization_state.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../organization/bloc/organization_bloc.dart';
import '../organization/state/organization_state.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_employee_bloc.dart';

@RoutePage()
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(UserLoadEvent());
    BlocProvider.of<UserOrganizationBloc>(
      context,
    ).add(UserOrganizationRefreshEvent());
    BlocProvider.of<UserEmployeeBloc>(context).add(UserEmployeeLoadEvent());
    BlocProvider.of<OrganizationCurrentBloc>(
      context,
    ).add(OrganizationRefreshEvent())super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Stamp.menuSupplier(context),
        appBar: AppBar(
          title: Text('Пользовательские данные'),
          actions: [Stamp.buttonMenuSupplier(context)],
          // leading: Stamp.buttonMenu(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Отображаем основное имя и телефон
              _user(context),
              const Divider(),
              _organization(context),
              // Список организаций владельца
              _userOrganization(context),
              // Список сотрудников/организаций сотрудника
              _userEmployee(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _user(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserLoadedState) {
          return Column(
            children: [
              Text(
                'Имя: ${state.user?.name}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text('Телефон: ${state.user?.phone}'),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget _organization(BuildContext context) {
    return BlocConsumer<OrganizationCurrentBloc, OrganizationCurrentState>(
      listener: (context, state) {
        if (state is OrganizationErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is OrganizationUnSelectedState) {
          return Text('Выбирете организацию, с которой будете работать');
        } else if (state is OrganizationSelectedState) {
          return Card(
            color: Colors.blue.shade100,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.workspace_premium),
              title: Text('Выбранная организация'),
              subtitle: Text(
                  'Организация: ${state.selected.organization.name}'),
              trailing: OutlinedButton.icon(
                // Добавили кнопку с иконкой
                icon: Icon(Icons.keyboard_arrow_right),
                label: Text("Продолжить"),
                onPressed: () {
                  AutoRouter.of(context).push(HomeRoute());
                },
              ),
            ),
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }

  Widget _userEmployee(BuildContext context) {
    return BlocConsumer<UserEmployeeBloc, UserEmployeeState>(
      listener: (context, state) {
        if (state is UserEmployeeErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserEmployeeInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserEmployeeLoadedState) {
          return Column(
            children: [
              const Divider(),
              const Text(
                'Вы работник в организациях:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (final empOrg in state.employee!.employees)
                Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.work),
                    title: Text(empOrg.organization.name),
                    subtitle: Text('Роль: ${empOrg.role.name}'),
                    trailing: OutlinedButton.icon(
                      // Добавили кнопку с иконкой
                      icon: Icon(Icons.keyboard_arrow_right),
                      label: Text("Выбрать"),
                      onPressed: () {
                        BlocProvider.of<OrganizationCurrentBloc>(context).add(
                          OrganizationSelectedEvent(id: empOrg.organization.id),
                        );
                        AutoRouter.of(context).push(HomeRoute());
                      },
                    ),
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

  Widget _userOrganization(BuildContext context) {
    return BlocConsumer<UserOrganizationBloc, UserOrganizationState>(
      listener: (BuildContext context, UserOrganizationState state) {
        if (state is UserOrganizationErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (state is UserOrganizationInitState) {
          return Stamp.loadWidget(context);
        } else if (state is UserOrganizationLoadedState) {
          return Column(
            children: [
              const Divider(),
              const Text(
                'Ваши организации:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if (state.organization?.organizations != null)
                for (final org in state.organization!.organizations)
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(Icons.business),
                      title: Row(
                        children: [
                          TextButton(
                            style: Stamp.giperLink(),
                            onPressed: () {
                              BlocProvider.of<OrganizationCurrentBloc>(
                                context,
                              ).add(OrganizationSelectedEvent(id: org.id));
                              AutoRouter.of(context).push(OrganizationRoute());
                            },
                            child: Text(org.name,),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              BlocProvider.of<OrganizationEditBloc>(
                                context,
                              ).add(OrganizationEditDeleteEvent(id: org.id));
                            },
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text('Владелец: ${org.owner.name}'),
                        ],
                      ),
                      trailing: // Кнопка выбора
                      OutlinedButton.icon(
                        icon: Icon(Icons.keyboard_arrow_right),
                        label: Text("Выбрать"),
                        onPressed: () {
                          BlocProvider.of<OrganizationCurrentBloc>(
                            context,
                          ).add(OrganizationSelectedEvent(id: org.id));
                          AutoRouter.of(context).push(HomeRoute());
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
                  title: Text("Добавить организацию"),
                  onTap: () {
                    BlocProvider.of<OrganizationCurrentBloc>(
                      context,
                    ).add(OrganizationUnSelectedEvent());
                    AutoRouter.of(context).push(OrganizationRoute());
                  }, // Обработчик нажатия
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
}

enum MenuItem { itemOne, itemTwo }
