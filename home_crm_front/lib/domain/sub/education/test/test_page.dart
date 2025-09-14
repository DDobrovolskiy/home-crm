import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:home_crm_front/domain/sub/education/test/state/test_edit_state.dart';

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
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _timeLimitMinutes;

  final _testEditBloc = GetIt.instance.get<TestEditBloc>();

  @override
  void initState() {
    _testEditBloc.add(TestEditLoadEvent(id: widget.testId));
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
                    fieldEdit('Название теста', state.data?.test.name, (value) {
                      _name = value;
                    }),
                    SizedBox(height: 5),
                    fieldNumberEdit(
                      'Время выполнениния в минутах (0 - без ограничений)',
                      state.data?.test.timeLimitMinutes,
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
                            id: state.data!.test.id,
                            name: _name ?? state.data!.test.name,
                            timeLimitMinutes:
                                _timeLimitMinutes ??
                                state.data!.test.timeLimitMinutes,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Тест готов: '),
                        Checkbox(
                          value: state.data?.test.ready ?? false,
                          onChanged: (bool? value) {
                            _testEditBloc.add(
                              TestEditUpdateReadyEvent(
                                id: widget.testId,
                                ready: value ?? false,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('Вопросы: '),
                    SizedBox(height: 5),
                    if (state.data != null &&
                        state.data?.testQuestions.questions != null)
                      Column(
                        children: [
                          for (
                            int i = 0;
                            i < state.data!.testQuestions.questions.length;
                            i++
                          )
                            Row(
                              children: [
                                Text('${i + 1}. '),
                                Text(
                                  state.data!.testQuestions.questions[i].text,
                                ),
                                ?edit(
                                  context,
                                  state.data!.testQuestions.questions[i],
                                ),
                                Spacer(),
                                ?delete(
                                  context,
                                  state.data!.testQuestions.questions[i],
                                ),
                              ],
                            ),
                        ],
                      ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      child: Text('Добавить вопрос'),
                      onPressed: () {},
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
}

Widget fieldEdit(String nameVal, String? val, ValueChanged<String>? onChanged) {
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
  return OutlinedButton.icon(
    // Добавили кнопку с иконкой
    icon: Icon(Icons.edit),
    label: Text("Редактировать"),
    onPressed: () {
      // AutoRouter.of(context).push(RoleRoute(roleId: role.role.id));
    },
  );
}

Widget? delete(BuildContext context, QuestionDto question) {
  return IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {
      // BlocProvider.of<TestEditBloc>(
      //   context,
      // ).add(TestEditDeleteEvent(id: test.test.id));
    },
  );
}
