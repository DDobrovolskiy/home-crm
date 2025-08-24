import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/sub/organization/actions/organization_actions.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';
import '../../support/router/roters.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
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
                      'Имя: ${store.state.userState?.name}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text('Телефон: ${store.state.userState?.phone}'),
                    // Список организаций владельца
                    Column(
                      children: [
                        const Divider(),
                        const Text(
                          'Ваши организации:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (store.state.userState != null)
                          for (final org
                              in store.state.userState!.ownerOrganizations)
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
                                        store.dispatch(
                                          OrganizationDeleteAction(id: org.id),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      'Организация: ${org.name}\nВладелец: ${org
                                          .owner.name}',
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        store.dispatch(
                                          OrganizationInitUpdateAction(
                                              org: org),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                trailing: // Кнопка выбора
                                OutlinedButton.icon(
                                  icon: Icon(Icons.keyboard_arrow_right),
                                  label: Text("Выбрать"),
                                  onPressed: () {},
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
                              store.dispatch(
                                NavigateToAction.replace(
                                  RoutersApp.organization,
                                ),
                              );
                            }, // Обработчик нажатия
                          ),
                        ),
                      ],
                    ),

                    // Список сотрудников/организаций сотрудника
                    if (store.state.userState != null &&
                        store.state.userState!.employeeOrganizations.isNotEmpty)
                      Column(
                        children: [
                          const Divider(),
                          const Text(
                            'Вы работник в организациях:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          for (final empOrg
                              in store.state.userState!.employeeOrganizations)
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
                                  onPressed: () {},
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
      },
    );
  }
}
