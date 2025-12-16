import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/state/employee_test_state.dart';
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
            // if (test.ready)
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
                      AutoRouter.of(context).push(
                        EmployeeTestRunRoute(
                          testId: test.id,
                          employeeId: state.data!.employee.id,
                        ),
                      );
                    },
                  ),
                ),
              ),
          Text('Незаконченные тесты:', textAlign: TextAlign.left),
          for (final session in state.data!.employeeSessions.sessions)
            if (session.active)
              Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.text_snippet_outlined),
                title: Text(session.test.name),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text('Ограничение по времени до: '),
                        session.test.timeLimitMinutes == 0
                            ? Text('нет')
                            : Text(session.endTime),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    AutoRouter.of(context).push(
                      EmployeeTestRunRoute(
                        testId: session.test.id,
                        employeeId: state.data!.employee.id,
                      ),
                    );
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
}
