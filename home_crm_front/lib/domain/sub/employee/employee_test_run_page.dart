import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:home_crm_front/domain/sub/education/result/dto/response/result_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/bloc/session_bloc.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/request/session_result_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/event/session_event.dart';

import '../../support/widgets/stamp.dart';
import '../education/session/cubit/session_result.dart';
import '../education/session/dto/request/session_result_question_dto.dart';
import '../education/session/state/session_state.dart';

@RoutePage()
class EmployeeTestRunPage extends StatefulWidget {
  final int testId;
  final int employeeId;

  const EmployeeTestRunPage({
    super.key,
    required this.testId,
    required this.employeeId,
  });

  @override
  _EmployeeTestRunPageState createState() => _EmployeeTestRunPageState();
}

class _EmployeeTestRunPageState extends State<EmployeeTestRunPage> {
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
      listener: (context, state) {
        if (state.error != null) {
          Stamp.showTemporarySnackbar(context, state.error!.message);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  state.loaded
                      ? Text(state.data!.session.test.name)
                      : Stamp.loadWidget(context),
                  if (state.data?.session.endTime != null)
                    Text(' до: ${state.data!.session.endTime}'),
                ],
              ),
            ),
            body: getContent(context, state),
          ),
        );
      },
    );
  }

  Widget getContent(BuildContext context, SessionState state) {
    if (state.data == null) {
      return Stamp.loadWidget(context);
    } else {
      int max = state.data!.test.questions.length - 1;
      if (answers.isEmpty) {
        for (var q in state.data!.test.questions) {
          answers.add(
            SessionResultQuestionDto(questionId: q.question.id!, options: {}),
          );
        }
      }
      return Column(
        children: [
          Text('Вопрос: '),
          Text(state.data!.test.questions[currentIndex].question.text),
          Text('Варианты ответов: '),
          fieldMultySelected(
            state.data!.test.questions[currentIndex].questionOptions.options,
            answers[currentIndex],
            state.data!.test.questions[currentIndex].questionOptions.oneAnswer,
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
                  Navigator.pop(context);
                  GetIt.I
                      .get<SessionResultCubit>()
                      .sendResult(
                        SessionResultDto(
                          sessionId: state.data!.session.id,
                          questions: answers,
                        ),
                      )
                      .then((value) {
                        openAddDialog(value);
                      });
                },
              ),
              TextButton(
                child: const Text('Выйти'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      );
    }
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
                  answerQuestion.options.add(option.id!);
                } else {
                  answerQuestion.options.add(option.id!);
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

  void openAddDialog(ResultDto? value) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Результат теста: ${value?.test.name}'),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Правильных ответов: ${value?.details.where((d) => d.isCorrect).length} из ${value?.details.length}',
                ),
                TextButton(
                  child: const Text('Назад'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
