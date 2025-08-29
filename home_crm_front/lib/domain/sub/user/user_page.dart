import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/user/event/user_event.dart';
import 'package:home_crm_front/domain/sub/user/user_state/user_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import 'bloc/user_bloc.dart';

@RoutePage()
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    _userBloc.add(UserLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is UserInitial) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // Стандартное кольцо загрузки
            ),
          );
        } else if (state is UserLoadState) {
          return SafeArea(
            child: MaterialApp(
              home: Scaffold(
                appBar: AppBar(title: Text('Пользовательские данные')),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Отображаем основное имя и телефон
                      Text(
                        'Имя: ${state.user?.name}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text('Телефон: ${state.user?.phone}'),
                      // Список организаций владельца
                      Column(
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
                                      Text(org.name),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          // store.dispatch(
                                          //   OrganizationDeleteAction(id: org.id),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        'Организация: ${org.name}\nВладелец: ${org.owner.name}',
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          // store.dispatch(
                                          //   OrganizationInitUpdateAction(
                                          //       org: org),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                  trailing: // Кнопка выбора
                                  OutlinedButton.icon(
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    label: Text("Выбрать"),
                                    onPressed: () {
                                      // store.dispatch(
                                      //   OrganizationChooseAction(id: org.id),
                                      // );
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
                                // store.dispatch(
                                //   NavigateToAction.replace(
                                //     RoutersApp.organization,
                                //   ),
                                // );
                              }, // Обработчик нажатия
                            ),
                          ),
                        ],
                      ),

                      // Список сотрудников/организаций сотрудника
                      if (state.employee?.employees != null)
                        Column(
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
                                  subtitle: Text(
                                    'Организация: ${empOrg.organization.name}, Роль: ${empOrg.role.name}',
                                  ),
                                  trailing: OutlinedButton.icon(
                                    // Добавили кнопку с иконкой
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    label: Text("Выбрать"),
                                    onPressed: () {
                                      // store.dispatch(
                                      //   OrganizationChooseAction(id: empOrg.id),
                                      // );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is UserAuthState) {
          AutoRouter.of(context).push(LoginRoute());
          return Text('Пользователь не авторизован');
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }
}
