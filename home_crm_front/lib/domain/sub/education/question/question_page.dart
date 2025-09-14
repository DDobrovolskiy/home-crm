import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_option_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/event/question_edit_event.dart';
import 'package:home_crm_front/domain/sub/education/question/event/question_option_event.dart';
import 'package:home_crm_front/domain/sub/education/question/state/question_edit_state.dart';
import 'package:home_crm_front/domain/sub/education/question/state/question_option_state.dart';

import '../../../support/widgets/stamp.dart';

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
  final _formKey = GlobalKey<FormState>();
  String? _text;
  int? _timeLimitMinutes;

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

Widget? edit(BuildContext context, OptionDto question) {
  return OutlinedButton.icon(
    // Добавили кнопку с иконкой
    icon: Icon(Icons.edit),
    label: Text("Редактировать"),
    onPressed: () {
      // AutoRouter.of(context).push(RoleRoute(roleId: role.role.id));
    },
  );
}

Widget? delete(BuildContext context, OptionDto question) {
  return IconButton(
    icon: Icon(Icons.delete),
    onPressed: () {
      // BlocProvider.of<TestEditBloc>(
      //   context,
      // ).add(TestEditDeleteEvent(id: test.test.id));
    },
  );
}
