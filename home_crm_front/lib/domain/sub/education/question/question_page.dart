import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/option/bloc/option_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:home_crm_front/domain/sub/education/option/event/opion_edit_event.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_option_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/event/question_edit_event.dart';
import 'package:home_crm_front/domain/sub/education/question/event/question_option_event.dart';
import 'package:home_crm_front/domain/sub/education/question/state/question_edit_state.dart';
import 'package:home_crm_front/domain/sub/education/question/state/question_option_state.dart';

import '../../../support/widgets/stamp.dart';
import '../option/state/option_edit_state.dart';

@RoutePage()
class QuestionPage extends StatefulWidget {
  const QuestionPage({
    super.key,
    @PathParam("testId") required this.testId,
    @PathParam("questionId") required this.questionId,
  });

  final int testId;
  final int questionId;

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final textController = TextEditingController(); // Контроллер для поля ввода
  final formKey = GlobalKey<FormState>(); // Глобальный ключ формы для валидации
  final _formKey = GlobalKey<FormState>();
  String? _text;

  final _questionEditBloc = GetIt.I.get<QuestionEditBloc>();
  final _questionOptionBloc = GetIt.I.get<QuestionOptionBloc>();

  @override
  void initState() {
    _questionEditBloc.add(
      QuestionEditLoadEvent(id: widget.questionId, testId: widget.testId),
    );
    _questionOptionBloc.add(
      QuestionOptionRefreshEvent(questionId: widget.questionId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionEditBloc, QuestionEditState>(
      listener: (context, state) {
        if (state.error != null) {
          _questionEditBloc.add(
            QuestionEditLoadEvent(id: widget.questionId, testId: widget.testId),
          );
        } else if (state.isEndEdit) {
          Stamp.showTemporarySnackbar(context, 'Значения обновлены');
          _questionEditBloc.add(
            QuestionEditLoadEvent(id: widget.questionId, testId: widget.testId),
          );
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

  getContent(BuildContext context, QuestionEditState state) {
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
          appBar: AppBar(title: Text('Редактирование вопроса:')),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    fieldEdit('Текст вопроса', state.data?.text, (value) {
                      _text = value;
                    }),
                    SizedBox(height: 5),
                    ElevatedButton(
                      child: Text('Обновить значения'),
                      onPressed: () {
                        _questionEditBloc.add(
                          QuestionEditUpdateEvent(
                            id: state.data!.id,
                            text: _text ?? state.data!.text,
                            testId: widget.testId,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    Text('Варианты ответов: '),
                    SizedBox(height: 5),
                    getOptions(),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      child: Text('Добавить вариант ответа'),
                      onPressed: () {
                        openAddDialog(null);
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

  Widget getOptions() {
    return BlocConsumer<QuestionOptionBloc, QuestionOptionState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.loaded) {
          var dto = state.data!;
          return Column(
            children: [
              if (dto.validMessage != null)
                Row(children: [Icon(Icons.warning), Text(dto.validMessage!)]),
              dto.oneAnswer
                  ? Text('Вариантов ответа один')
                  : Text('Вариантов ответа больше одного'),
              for (int i = 0; i < dto.options.length; i++)
                Row(
                  children: [
                    Text('${i + 1}. '),
                    if (dto.options[i].correct) Text('(Правильный ответ) '),
                    Text(dto.options[i].text),
                    ?edit(context, dto.options[i]),
                    Spacer(),
                    ?delete(context, dto.options[i]),
                  ],
                ),
            ],
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

  Widget? edit(BuildContext context, OptionDto question) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        openAddDialog(question.id);
      },
    );
  }

  Widget? delete(BuildContext context, OptionDto question) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        BlocProvider.of<OptionEditBloc>(context).add(
          OptionEditDeleteEvent(id: question.id,
              questionId: widget.questionId,
              testId: widget.testId),
        );
      },
    );
  }

  void openAddDialog1(int? id) {
    showDialog(
      context: context,
      builder: (context) {
        GetIt.I.get<OptionEditBloc>().add(
          OptionEditLoadEvent(
              id: id, questionId: widget.questionId, testId: widget.testId),
        );
        return Container();
      },
    );
  }

  void openAddDialog(int? id) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogWidget(
            id: id, questionId: widget.questionId, testId: widget.testId);
      },
    );
  }
}

// Виджет с внутренним состоянием для диалога
class CustomDialogWidget extends StatefulWidget {
  final int testId;
  final int questionId;
  final int? id;

  const CustomDialogWidget(
      {super.key, required this.questionId, this.id, required this.testId,});

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _correctSelected;
  String? _text;

  @override
  void initState() {
    GetIt.I.get<OptionEditBloc>().add(
      OptionEditLoadEvent(
          id: widget.id, questionId: widget.questionId, testId: widget.testId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OptionEditBloc, OptionEditState>(
      listener: (context, state) {
        if (state.isEndEdit) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return Stamp.loadWidget(context);
        } else {
          return SimpleDialog(
            title: state.data == null
                ? Text('Добавить новый ответ')
                : Text('Редактировать ответ'),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _text ?? state.data?.text ?? '',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Текст ответа не должен быть пустым!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Введите текст вопроса',
                      ),
                      onChanged: (value) => {_text = value},
                    ),
                    Row(
                      children: [
                        Text('Правильный вариант ответа: '),
                        Checkbox(
                          value:
                              _correctSelected ?? state.data?.correct ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              _correctSelected = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Отмена'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: state.data == null
                              ? Text('Добавить')
                              : Text('Изменить'),
                          onPressed: () {
                            if (widget.id == null) {
                              GetIt.I.get<OptionEditBloc>().add(
                                OptionEditCreateEvent(
                                  text: _text!,
                                  correct: _correctSelected ?? false,
                                  questionId: widget.questionId,
                                    testId: widget.testId
                                ),
                              );
                            } else {
                              GetIt.I.get<OptionEditBloc>().add(
                                OptionEditUpdateEvent(
                                  id: widget.id!,
                                  text: _text ?? state.data!.text,
                                  correct:
                                      _correctSelected ?? state.data!.correct,
                                  questionId: widget.questionId,
                                    testId: widget.testId
                                ),
                              );
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
        }
      },
    );
  }
}
