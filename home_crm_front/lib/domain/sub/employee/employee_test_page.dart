import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/bloc/session_bloc.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/request/session_result_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/event/session_event.dart';
import 'package:home_crm_front/domain/sub/employee/state/employee_test_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../support/widgets/stamp.dart';
import '../education/session/cubit/session_result.dart';
import '../education/session/dto/request/session_result_question_dto.dart';
import '../education/session/state/session_state.dart';
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
                      // openAddTestDialog(test.id, state.data!.employee.id);
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
                    // openAddTestDialog(session.test.id, state.data!.employee.id);
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

  void openAddTestDialog(int testId, int employeeId) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogWidget(testId: testId, employeeId: employeeId);
      },
    );
  }
}

// Виджет с внутренним состоянием для диалога
class CustomDialogWidget extends StatefulWidget {
  final int testId;
  final int employeeId;

  const CustomDialogWidget({
    super.key,
    required this.testId,
    required this.employeeId,
  });

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  int currentIndex = 0;
  List<SessionResultQuestionDto> answers = [];

  @override
  void initState() {
    GetIt.I.get<SessionBloc>().add(
      SessionRefreshEvent(testId: widget.testId, employeeId: widget.employeeId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.data == null) {
          return Stamp.loadWidget(context);
        } else {
          int max = state.data!.test.questions.length - 1;
          if (answers.isEmpty) {
            for (var q in state.data!.test.questions) {
              answers.add(
                SessionResultQuestionDto(
                  questionId: q.question.id,
                  options: {},
                ),
              );
            }
          }
          return SimpleDialog(
            title: Row(
              children: [
                Text(state.data!.session.test.name),
                if (state.data?.session.endTime != null)
                  Text(' до: ${state.data!.session.endTime}'),
              ],
            ),
            contentPadding: EdgeInsets.all(16),
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Вопрос: '),
                    Text(
                      state.data!.test.questions[currentIndex].question.text,
                    ),
                    Text('Варианты ответов: '),
                    fieldMultySelected(
                      state
                          .data!
                          .test
                          .questions[currentIndex]
                          .questionOptions
                          .options,
                      answers[currentIndex],
                      state
                          .data!
                          .test
                          .questions[currentIndex]
                          .questionOptions
                          .oneAnswer,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (currentIndex != 0)
                          TextButton(
                            child: const Text('Назад'),
                            onPressed: () => {
                              setState(() {
                                currentIndex--;
                              }),
                            },
                          ),
                        if (currentIndex != max)
                          TextButton(
                            child: const Text('Дальше'),
                            onPressed: () => {
                              setState(() {
                                currentIndex++;
                              }),
                            },
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Закончить'),
                          onPressed: () {
                            GetIt.I.get<SessionResultCubit>().sendResult(
                              SessionResultDto(
                                testId: widget.testId,
                                employeeId: widget.employeeId,
                                questions: answers,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text('Выйти'),
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

  Widget fieldMultySelected(
    List<OptionDto> options,
    SessionResultQuestionDto answerQuestion,
    bool oneAnswer,
  ) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (_, index) {
          final option = options[index];
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(option.text),
            value: answerQuestion.options.contains(option.id),
            activeColor: Colors.green,
            checkColor: Colors.white,
            onChanged: (bool? checked) {
              if (checked!) {
                if (oneAnswer) {
                  answerQuestion.options.clear();
                  answerQuestion.options.add(option.id);
                } else {
                  answerQuestion.options.add(option.id);
                }
              } else {
                answerQuestion.options.remove(option.id);
              }
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
