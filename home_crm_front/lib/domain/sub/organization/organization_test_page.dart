import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/response/test_view_dto.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_test_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../support/widgets/stamp.dart';
import '../education/test/bloc/test_edit_bloc.dart';
import '../education/test/event/test_edit_event.dart';
import 'bloc/organization_test_bloc.dart';
import 'event/organization_test_event.dart';

@RoutePage()
class OrganizationTestsPage extends StatefulWidget {
  const OrganizationTestsPage({super.key});

  @override
  _OrganizationTestsPageState createState() => _OrganizationTestsPageState();
}

class _OrganizationTestsPageState extends State<OrganizationTestsPage> {
  final textController = TextEditingController(); // Контроллер для поля ввода
  final formKey = GlobalKey<FormState>(); // Глобальный ключ формы для валидации

  @override
  void initState() {
    BlocProvider.of<OrganizationTestBloc>(
      context,
    ).add(OrganizationTestRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationTestBloc, OrganizationTestState>(
      listener: (context, state) {
        if (state is OrganizationTestErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text('Обучение в организации')),
            body: getContent(context, state),
          ),
        );
      },
    );
  }

  Widget getContent(BuildContext context, OrganizationTestState state) {
    if (!state.loaded) {
      return Stamp.loadWidget(context);
    } else if (state.organization != null) {
      return Column(
        children: [
          Text('Тесты:', textAlign: TextAlign.left),
          for (final test in state.organization!.tests)
            Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.text_snippet_rounded),
                title: Text(test.test.name),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        test.test.ready
                            ? Icon(Icons.done)
                            : Icon(Icons.play_arrow),
                        test.test.ready
                            ? Text('(Тест готов)')
                            : Text('(Тест в процессе создания)'),
                        ?delete(context, test, state),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Ограничение по времени (мин.): '),
                        test.test.timeLimitMinutes == 0
                            ? Text('нет')
                            : Text(test.test.timeLimitMinutes.toString()),
                      ],
                    ),
                    Text(
                      'Тест назначен сотрудникам:',
                      textAlign: TextAlign.left,
                    ),
                    Column(
                      children: [
                        for (final employee in test.testEmployees.employees)
                          Stamp.giperLinkText(
                            Text(employee.user.name, textAlign: TextAlign.left),
                            () {
                              AutoRouter.of(
                                context,
                              ).push(EmployeeRoute(employeeId: employee.id));
                            },
                          ),
                      ],
                    ),
                    Text(
                      'Следующие сотрудники проходят тест:',
                      textAlign: TextAlign.left,
                    ),
                    Column(
                      children: [
                        for (final session in test.testSessions.sessions)
                          Text(
                            session.employee.user.name,
                            textAlign: TextAlign.left,
                          ),
                      ],
                    ),
                  ],
                ),
                trailing: edit(context, test, state),
              ),
            ),
          // Кнопка добавления новой организации-владельца
          if (state.hasEdit)
            Card(
              color: Colors.blue.shade100,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.add_circle_outline),
                title: Text("Добавить тест"),
                onTap: () {
                  openAddDialog();
                },
              ),
            ),
        ],
      );
    } else {
      return Stamp.errorWidget(context);
    }
  }

  Widget? edit(
    BuildContext context,
    TestViewDto test,
    OrganizationTestState state,
  ) {
    if (state.hasEdit) {
      return OutlinedButton.icon(
        // Добавили кнопку с иконкой
        icon: Icon(Icons.edit),
        label: Text("Редактировать"),
        onPressed: () {
          // AutoRouter.of(context).push(RoleRoute(roleId: role.role.id));
        },
      );
    } else {
      return null;
    }
  }

  Widget? delete(
    BuildContext context,
    TestViewDto test,
    OrganizationTestState state,
  ) {
    if (state.hasEdit) {
      return IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          BlocProvider.of<TestEditBloc>(
            context,
          ).add(TestEditDeleteEvent(id: test.test.id));
        },
      );
    } else {
      return null;
    }
  }

  void openAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Добавить новый тест'),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: textController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Название теста не должно быть пустым!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Введите название теста',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Отмена'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Добавить'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final enteredName = textController.text;
                            textController.clear(); // Очистка поля ввода
                            GetIt.I.get<TestEditBloc>().add(
                              TestEditCreateEvent(name: enteredName),
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
