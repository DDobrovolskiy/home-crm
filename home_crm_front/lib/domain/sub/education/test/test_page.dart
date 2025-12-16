import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/event/question_edit_event.dart';
import 'package:home_crm_front/domain/sub/education/test/bloc/test_question_bloc.dart';
import 'package:home_crm_front/domain/sub/education/test/event/test_question_event.dart';
import 'package:home_crm_front/domain/sub/education/test/state/test_edit_state.dart';
import 'package:home_crm_front/domain/sub/education/test/state/test_question_state.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';

import '../../../support/widgets/stamp.dart';
import 'bloc/test_edit_bloc.dart';
import 'event/test_edit_event.dart';

@RoutePage()
class TestSuitPage extends StatefulWidget {
  const TestSuitPage({super.key, @PathParam("testId") required this.testId});

  final int testId;

  @override
  _TestSuitPageState createState() => _TestSuitPageState();
}

class _TestSuitPageState extends State<TestSuitPage> {
  final textController = TextEditingController(); // Контроллер для поля ввода
  final formKey = GlobalKey<FormState>(); // Глобальный ключ формы для валидации
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _timeLimitMinutes;

  final _testEditBloc = GetIt.I.get<TestEditBloc>();
  final _testQuestionBloc = GetIt.I.get<TestQuestionBloc>();

  @override
  void initState() {
    _testEditBloc.add(TestEditLoadEvent(id: widget.testId));
    _testQuestionBloc.add(TestQuestionRefreshEvent(testId: widget.testId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestEditBloc, TestEditState>(
      listener: (context, state) {
        if (state.error != null) {
          _testEditBloc.add(TestEditLoadEvent(id: widget.testId));
        } else if (state.isEndEdit) {
          Stamp.showTemporarySnackbar(context, 'Значения обновлены');
          _testEditBloc.add(TestEditLoadEvent(id: widget.testId));
        }
      },
      builder: (context, state) {
        if (state.error != null) {
          return SafeArea(
            child: Scaffold(appBar: AppBar(title: Text(state.error!.message))),
          );
        } else {
          return getContent(context, state);
        }
      },
    );
  }

  getContent(BuildContext context, TestEditState state) {
    if (state.isLoading) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Stamp.loadWidget(context)),
          body: Stamp.loadWidget(context),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Редактирование теста:')),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    fieldEdit('Название теста', state.data?.name, (value) {
                      _name = value;
                    }),
                    SizedBox(height: 5),
                    fieldNumberEdit(
                      'Время выполнениния в минутах (0 - без ограничений)',
                      state.data?.timeLimitMinutes,
                      (value) {
                        _timeLimitMinutes = int.tryParse(value) ?? 0;
                      },
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      child: Text('Обновить значения'),
                      onPressed: () {
                        _testEditBloc.add(
                          TestEditUpdateEvent(
                            id: state.data!.id,
                            name: _name ?? state.data!.name,
                            timeLimitMinutes:
                                _timeLimitMinutes ??
                                state.data!.timeLimitMinutes,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    // Row(
                    //   children: [
                    //     Text('Тест готов: '),
                    //     Checkbox(
                    //       value: state.data?.ready ?? false,
                    //       onChanged: (bool? value) {
                    //         _testEditBloc.add(
                    //           TestEditUpdateReadyEvent(
                    //             id: widget.testId,
                    //             ready: value ?? false,
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 5),
                    Text('Вопросы: '),
                    SizedBox(height: 5),
                    // getQuestions(state.data?.ready ?? false),
                    const SizedBox(height: 32),
                    // if (!(state.data?.ready ?? false))
                    ElevatedButton(
                        child: Text('Добавить вопрос'),
                        onPressed: () {
                          openAddDialog();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void openAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Добавить новый вопрос'),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: textController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Текст вопроса не должен быть пустым!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Введите текст вопроса',
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
                            GetIt.I.get<QuestionEditBloc>().add(
                              QuestionEditCreateEvent(
                                text: enteredName,
                                testId: widget.testId,
                              ),
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

  Widget getQuestions(bool ready) {
    return BlocConsumer<TestQuestionBloc, TestQuestionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.loaded) {
          return Container(
            child: Column(
              children: [
                for (int i = 0; i < state.test!.questions.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('${i + 1}. '),
                          Flexible(
                            child: Text(
                              state.test!.questions[i].question.text,
                              softWrap: true,
                            ),
                          ),
                          if (!ready)
                            ?edit(context, state.test!.questions[i].question),
                          if (!ready)
                            ?delete(context, state.test!.questions[i].question),
                        ],
                      ),
                      if (state
                              .test!
                              .questions[i]
                              .questionOptions
                              .validMessage !=
                          null)
                        Row(
                          children: [
                            Icon(Icons.warning),
                            Text(
                              softWrap: true,
                              state
                                      .test!
                                      .questions[i]
                                      .questionOptions
                                      .validMessage ??
                                  '',
                            ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          );
        } else {
          return Stamp.loadWidget(context);
        }
      },
    );
  }

  Widget fieldEdit(
    String nameVal,
    String? val,
    ValueChanged<String>? onChanged,
  ) {
    return TextFormField(
      decoration: InputDecoration(labelText: nameVal),
      initialValue: val,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Поле не должно быть пустым';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget fieldNumberEdit(
    String nameVal,
    int? val,
    ValueChanged<String>? onChanged,
  ) {
    return TextFormField(
      decoration: InputDecoration(labelText: nameVal),
      initialValue: val.toString(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || RegExp(r'\d{4}').hasMatch(value)) {
          return 'Поле не должно быть пустым';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget? edit(BuildContext context, QuestionDto question) {
    return IconButton(
      // Добавили кнопку с иконкой
      icon: Icon(Icons.edit),
      onPressed: () {
        AutoRouter.of(
          context,
        ).push(QuestionRoute(testId: widget.testId, questionId: question.id));
      },
    );
  }

  Widget? delete(BuildContext context, QuestionDto question) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        BlocProvider.of<QuestionEditBloc>(
          context,
        ).add(QuestionEditDeleteEvent(id: question.id, testId: widget.testId));
      },
    );
  }
}
