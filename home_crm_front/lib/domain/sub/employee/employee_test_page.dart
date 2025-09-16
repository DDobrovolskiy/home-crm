import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/test/cubit/test_assign.dart';
import 'package:home_crm_front/domain/sub/employee/state/employee_test_state.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_test_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_test_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_test_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../support/widgets/stamp.dart';
import 'bloc/employee_test_bloc.dart';
import 'event/employee_test_event.dart';

@RoutePage()
class EmployeeTestsPage extends StatefulWidget {
  const EmployeeTestsPage({super.key});

  @override
  _EmployeeTestsPageState createState() => _EmployeeTestsPageState();
}

class _EmployeeTestsPageState extends State<EmployeeTestsPage> {
  @override
  void initState() {
    BlocProvider.of<EmployeeTestBloc>(context).add(EmployeeTestRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeTestBloc, EmployeeTestState>(
      listener: (context, state) {
        if (state is EmployeeTestErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text('Назначенное обучение')),
            body: getContent(context, state),
          ),
        );
      },
    );
  }

  Widget getContent(BuildContext context, EmployeeTestState state) {
    if (!state.loaded) {
      return Stamp.loadWidget(context);
    } else if (state.data != null) {
      return Column(
        children: [
          Text('Назначенные тесты:', textAlign: TextAlign.left),
          for (final test in state.data!.employeeTests.tests)
            if (test.ready)
              Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.text_snippet_outlined),
                  title: Text(test.name),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text('Ограничение по времени (мин.): '),
                          test.timeLimitMinutes == 0
                              ? Text('нет')
                              : Text(test.timeLimitMinutes.toString()),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () {
                      openAddTestDialog(test.id);
                    },
                  ),
                ),
              ),
        ],
      );
    } else {
      return Text('Назначенных тестов нет');
    }
  }

  void openAddTestDialog(int testId) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogWidget(testId: testId);
      },
    );
  }
}

// Виджет с внутренним состоянием для диалога
class CustomDialogWidget extends StatefulWidget {
  final int testId;

  const CustomDialogWidget({super.key, required this.testId});

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  void initState() {
    GetIt.I.get<OrganizationEmployeeTestBloc>().add(
      OrganizationEmployeeTestRefreshEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      OrganizationEmployeeTestBloc,
      OrganizationEmployeeTestState
    >(
      listener: (context, state) {},
      builder: (context, state) {
        if (!state.loaded) {
          return Stamp.loadWidget(context);
        } else {
          return SimpleDialog(
            title: Text('Назначить тест'),
            children: [
              Form(
                child: Column(
                  children: [
                    for (final employee in state.organization!.employees)
                      Row(
                        children: [
                          Stamp.giperLinkText(
                            Text(
                              employee.employee.user.name,
                              textAlign: TextAlign.left,
                            ),
                            () {
                              AutoRouter.of(context).push(
                                EmployeeRoute(employeeId: employee.employee.id),
                              );
                            },
                          ),
                          Spacer(),
                          Text('Назначен: '),
                          Checkbox(
                            value: employee.employeeTests.tests.any(
                              (test) => test.id == widget.testId,
                            ),
                            onChanged: (bool? value) {
                              if (employee.employeeTests.tests.any(
                                (test) => test.id == widget.testId,
                              )) {
                                GetIt.I.get<TestAssignCubit>().unassignTest(
                                  widget.testId,
                                  employee.employee.id,
                                );
                              } else {
                                GetIt.I.get<TestAssignCubit>().assignTest(
                                  widget.testId,
                                  employee.employee.id,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Назад'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
