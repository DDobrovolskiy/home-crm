import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:home_crm_front/domain/support/components/label/label_page.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';

import '../../../../../theme/theme.dart';
import '../../../../support/components/button/button.dart';
import '../../../../support/components/callback/NavBarCallBack.dart';
import '../../../../support/components/dialog/custom_dialog.dart';
import '../../../../support/components/status/doc.dart';
import '../../../../support/components/tab/custom_tab.dart';
import '../../../../support/components/table/table.dart';
import '../../../../support/components/table/table_head_row.dart';
import '../../../../support/components/table/table_head_row_cell.dart';
import '../../../../support/components/table/table_row.dart';
import '../../../../support/components/table/table_row_cell.dart';
import '../../question/dto/response/question_dto.dart';
import '../dto/response/test_dto.dart';

class TestDialog extends SheetPage {
  static Future<TestDto?> show(BuildContext context, TestDto? test) async {
    return CustomDialog.showDialog<TestDto?>(TestDialog(test: test), context);
  }

  @override
  String getName() {
    return test?.number ?? 'Новый тест';
  }

  final TestDto? test;

  const TestDialog({super.key, this.test});

  @override
  _TestDialogState createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog> {
  int? _id;
  String? _name;
  String? _description;
  StatusDoc? _status = StatusDoc.DRAFT;
  bool? _timeLimitMinutesFlag = true;
  int? _timeLimitMinutes = 0;
  bool? _iterationFlag = true;
  int? _iteration = 0;
  List<QuestionDto> _questions = [];

  @override
  void initState() {
    super.initState();
    var test = widget.test;
    if (test != null) {
      _id = test.id;
      _name = test.name;
      _description = test.description;
      _status = test.status;
      _timeLimitMinutes = test.timeLimitMinutes;
      _iteration = test.iteration;
      _questions = test.questions;

      _timeLimitMinutesFlag = _timeLimitMinutes == 0;
      _iterationFlag = _iteration == 0;
    }
  }

  bool isCreate() {
    return widget.test == null;
  }

  @override
  Widget build(BuildContext context) {
    return DialogPage(
      label: (validator) {
        return Column(
          children: [
            CustomLabelPage(
              contents: [
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
                  child: CustomButtonDisplay(
                    primary: true,
                    text: 'Сохранить и закрыть',
                    onPressed: () async {
                      if (validator()) {
                        GetIt.I.get<SheetElementDeleteCallback>().call(
                          widget.getName(),
                        );
                      }
                      // if (_formKey.currentState!.validate()) {
                      //   if (isCreate()) {
                      //     // var resul = await GetIt.I
                      //     //     .get<EmployeeService>()
                      //     //     .addEmployee(
                      //     //   EmployeeCreateDto(
                      //     //     name: _name!,
                      //     //     phone: _phone!,
                      //     //     password: _password!,
                      //     //     roleId: _selectedRole!,
                      //     //   ),
                      //     // );
                      //   } else {
                      //     // var resul = await GetIt.I
                      //     //     .get<EmployeeService>()
                      //     //     .updateEmployee(
                      //     //   EmployeeUpdateDto(
                      //     //     id: _id!,
                      //     //     roleId: _selectedRole!,
                      //     //   ),
                      //     // );
                      //   }
                      //
                      // }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
                  child: IconButton(
                    onPressed: () async {},
                    color: CustomColors.getSecondaryText(context),
                    icon: Icon(Icons.save, size: 44),
                  ),
                ),
                Text(
                  widget.getName(),
                  textAlign: TextAlign.start,
                  style: CustomColors.getDisplaySmall(context, null),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Row(children: [CustomStatusDoc(status: _status!)]),
                ),
              ],
            ),
          ],
        );
      },
      contents: [
        (key) => CustomTabView(name: 'Основное', child: main(key)),
        (key) => CustomTabView(
          name: 'Вопросы',
          child: questions(key),
          label: () => _questions.length,
        ),
      ],
    );
  }

  Widget main(GlobalKey<FormState> _formKeyTab) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 16, 2, 2),
      child: Form(
        key: _formKeyTab,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                    child: TextFormField(
                      decoration: CustomColors.getTextFormInputDecoration(
                        'Название теста *',
                        null,
                        context,
                        true,
                      ),
                      style: CustomColors.getBodyMedium(context, null),
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Необходимо ввести название теста';
                        }
                        return null;
                      },
                      onChanged: (value) => _name = value,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: CustomColors.getTextFormInputDecoration(
                              'Время выполнениния в минутах *',
                              null,
                              context,
                              true,
                            ),
                            style: CustomColors.getBodyMedium(context, null),
                            maxLines: null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: _timeLimitMinutes.toString(),
                            validator: (value) {
                              if (value == null ||
                                  RegExp(r'\d{4}').hasMatch(value)) {
                                return 'Необходимо ввести выполнениния в минутах';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _timeLimitMinutes = int.tryParse(value) ?? 0;
                                _timeLimitMinutesFlag = _timeLimitMinutes == 0;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            children: [
                              Text('Без ограничений: '),
                              Checkbox(
                                value: _timeLimitMinutesFlag,
                                activeColor: CustomColors.getPrimary(context),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      if (value) {
                                        _timeLimitMinutes = 0;
                                      }
                                    }
                                    _timeLimitMinutesFlag = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: CustomColors.getTextFormInputDecoration(
                              'Количество попыток *',
                              null,
                              context,
                              true,
                            ),
                            style: CustomColors.getBodyMedium(context, null),
                            maxLines: null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: _iteration.toString(),
                            validator: (value) {
                              if (value == null ||
                                  RegExp(r'\d{4}').hasMatch(value)) {
                                return 'Необходимо ввести выполнениния в минутах';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _iteration = int.tryParse(value) ?? 0;
                                _iterationFlag = _iteration == 0;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(10, 0, 0, 0),
                          child: Row(
                            children: [
                              Text('Без ограничений: '),
                              Checkbox(
                                value: _iterationFlag,
                                activeColor: CustomColors.getPrimary(context),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      if (value) {
                                        _timeLimitMinutes = 0;
                                      }
                                    }
                                    _iterationFlag = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                    child: TextFormField(
                      decoration: CustomColors.getTextFormInputDecoration(
                        'Описание теста',
                        null,
                        context,
                        false,
                      ),
                      style: CustomColors.getBodyMedium(context, null),
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _description,
                      validator: (value) {
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget questions(GlobalKey<FormState> _formKeyTab) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 16, 2, 2),
      child: Form(
        key: _formKeyTab,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(children: [tableQuestions(_questions)]),
      ),
    );
  }

  Widget tableQuestions(List<QuestionDto> questions) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          IconButton(
            onPressed: () async {
              setState(() {
                _questions.clear();
              });
            },
            color: CustomColors.getSecondaryText(context),
            icon: Icon(Icons.delete),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
            child: Text('№', style: CustomColors.getLabelMedium(context, null)),
          ),
          CustomTableHeadRowCell(text: 'Вопрос', textVisibleAlways: true),
          CustomTableHeadRowCell(
            flex: 2,
            text: 'Ответы',
            textVisibleAlways: true,
          ),
        ],
      ),
      rows: [
        for (int i = 0; i < _questions.length; i++)
          CustomTableRow(
            error: getError(_questions[i]),
            cells: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    _questions.removeAt(i);
                  });
                },
                color: CustomColors.getSecondaryText(context),
                icon: Icon(Icons.delete_outline),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                child: Text(
                  (i + 1).toString(),
                  style: CustomColors.getBodyLarge(context, null),
                ),
              ),
              CustomTableRowCell(
                textVisibleAlways: true,
                body: TextFormField(
                  decoration: CustomColors.getTextFormInputDecoration(
                    'Вопрос',
                    null,
                    context,
                    true,
                  ),
                  style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                  autovalidateMode:
                  AutovalidateMode.always,
                  initialValue: _questions[i].text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Необходимо ввести текст вопроса';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _questions[i].text = value;
                    });
                  },
                ),
              ),
              CustomTableRowCell(
                flex: 2,
                textVisibleAlways: true,
                body: Column(
                  children: [tableOptions(_questions[i].options)],
                ),
              ),
            ],
          ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    _questions.add(QuestionDto(text: '', options: []));
                  });
                },
                color: CustomColors.getSecondaryText(context),
                icon: Icon(Icons.add_circle),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? getError(QuestionDto question) {
    if (question.options.isEmpty || question.options.length < 2) {
      return 'Необходимо добавить хотя бы два ответа';
    }
    if (!question.options.any((o) => o.correct)) {
      return 'Должен быть хотя бы один правильный ответ';
    }
    return null;
  }


  Widget tableOptions(List<OptionDto> options) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          IconButton(
            onPressed: () async {
              setState(() {
                options.clear();
              });
            },
            color: CustomColors.getSecondaryText(context),
            icon: Icon(Icons.delete),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
            child: Text('№', style: CustomColors.getLabelMedium(context, null)),
          ),
          CustomTableHeadRowCell(text: 'Верный ответ', textVisibleAlways: true),
          CustomTableHeadRowCell(
            flex: 3,
            text: 'Варианты ответов',
            textVisibleAlways: true,
          ),
        ],
      ),
      rows: [
        for (int o = 0; o < options.length; o++)
          CustomTableRow(
            cells: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    options.removeAt(o);
                  });
                },
                color: CustomColors.getSecondaryText(context),
                icon: Icon(Icons.delete_outline),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                child: Text(
                  (o + 1).toString(),
                  style: CustomColors.getLabelMedium(context, null),
                ),
              ),
              CustomTableRowCell(
                body: Row(
                  children: [
                    Checkbox(
                      value: options[o].correct,
                      activeColor: CustomColors.getPrimary(context),
                      onChanged: (bool? value) {
                        setState(() {
                          options[o].correct = !options[o].correct;
                        });
                      },
                    ),
                  ],
                ),
                textVisibleAlways: true,
              ),
              CustomTableRowCell(
                flex: 3,
                textVisibleAlways: true,
                body: TextFormField(
                  decoration: CustomColors.getTextFormInputDecoration(
                    'Ответ',
                    null,
                    context,
                    true,
                  ),
                  style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                  autovalidateMode:
                  AutovalidateMode.always,
                  initialValue: options[o].text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Необходимо ввести текст ответа';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      options[o].text = value;
                    });
            },
          ),
              ),
            ],
          ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    options.add(OptionDto(text: '', correct: false));
                  });
                },
                color: CustomColors.getSecondaryText(context),
                icon: Icon(Icons.add_circle),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

