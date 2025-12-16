import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:home_crm_front/domain/support/components/label/label_page.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';

import '../../../../../theme/theme.dart';
import '../../../../support/components/button/button.dart';
import '../../../../support/components/button/hovered_region.dart';
import '../../../../support/components/callback/NavBarCallBack.dart';
import '../../../../support/components/dialog/custom_dialog.dart';
import '../../../../support/components/scope/check_scope.dart';
import '../../../../support/components/status/doc.dart';
import '../../../../support/components/tab/custom_tab.dart';
import '../../../../support/components/table/table.dart';
import '../../../../support/components/table/table_head_row.dart';
import '../../../../support/components/table/table_head_row_cell.dart';
import '../../../../support/components/table/table_row.dart';
import '../../../../support/components/table/table_row_cell.dart';
import '../../../scope/scope.dart';
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
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 6, 24, 12),
              child: Row(children: [CustomStatusDoc(status: _status!)]),
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
                      initialValue: _name,
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
      child: Column(children: [tableQuestions(_questions)]),
    );
  }

  Widget tableQuestions(List<QuestionDto> questions) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          Checkbox(
            value: false,
            activeColor: CustomColors.getPrimary(context),
            onChanged: (bool? value) {
              setState(() {});
            },
          ),
          Text('№', style: CustomColors.getLabelMedium(context, null)),
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
          HoveredRegion(
            onTap: () async {
              CheckScope(
                onTrue: () async {
                  _questions[i] = await showQuestion(context, _questions[i]);
                  setState(() {});
                },
              ).checkScope(ScopeType.TEST_CREATE, context);
            },
            child: (isHovered) {
              return CustomTableRow(
                hover: isHovered,
                cells: [
                  Checkbox(
                    value: false,
                    activeColor: CustomColors.getPrimary(context),
                    onChanged: (bool? value) {
                      setState(() {});
                    },
                  ),
                  Text(
                    (i + 1).toString(),
                    style: CustomColors.getLabelMedium(context, null),
                  ),
                  CustomTableRowCellText(
                    text: _questions[i].text,
                    textVisibleAlways: true,
                  ),
                  CustomTableRowCell(
                    flex: 2,
                    textVisibleAlways: true,
                    body: Column(
                      children: [tableOptions(_questions[i].options)],
                    ),
                  ),
                ],
              );
            },
          ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  var question = await showQuestion(context, null);
                  setState(() {
                    _questions.add(question);
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

  Future<QuestionDto> showQuestion(
    BuildContext context,
    QuestionDto? question,
  ) async {
    return CustomDialog.showDialog<QuestionDto>(
      QuestionDialog(question: question),
      context,
    );
  }

  Widget tableOptions(List<OptionDto> options) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          Checkbox(
            value: false,
            activeColor: CustomColors.getPrimary(context),
            onChanged: (bool? value) {
              setState(() {});
            },
          ),
          Text('№', style: CustomColors.getLabelMedium(context, null)),
          CustomTableHeadRowCell(text: 'Верный ответ', textVisibleAlways: true),
          CustomTableHeadRowCell(
            flex: 2,
            text: 'Ответ',
            textVisibleAlways: true,
          ),
        ],
      ),
      rows: [
        for (int o = 0; o < options.length; o++)
          HoveredRegion(
            onTap: () async {
              CheckScope(
                onTrue: () async {
                  options[o] = await showOption(context, options[o]);
                  setState(() {});
                },
              ).checkScope(ScopeType.TEST_CREATE, context);
            },
            child: (isHovered) {
              return CustomTableRow(
                hover: isHovered,
                cells: [
                  Checkbox(
                    value: false,
                    activeColor: CustomColors.getPrimary(context),
                    onChanged: (bool? value) {
                      setState(() {});
                    },
                  ),
                  Text(
                    (o + 1).toString(),
                    style: CustomColors.getLabelMedium(context, null),
                  ),
                  CustomTableRowCellText(
                    text: options[o].correct ? 'Да' : '',
                    textVisibleAlways: true,
                  ),
                  CustomTableRowCellText(
                    text: options[o].text,
                    textVisibleAlways: true,
                  ),
                ],
              );
            },
          ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  var option = await showOption(context, null);
                  setState(() {
                    options.add(option);
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

  Future<OptionDto> showOption(BuildContext context, OptionDto? option) async {
    return CustomDialog.showDialog<OptionDto>(
      OptionDialog(option: option),
      context,
    );
  }
}

class QuestionDialog extends StatefulWidget {
  final QuestionDto? question;

  const QuestionDialog({super.key, this.question});

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _text;

  bool isCreate() {
    return widget.question == null;
  }

  @override
  void initState() {
    super.initState();
    if (!isCreate()) {
      _text = widget.question?.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                child: TextFormField(
                  decoration: CustomColors.getTextFormInputDecoration(
                    'Текст вопроса *',
                    null,
                    context,
                    true,
                  ),
                  style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Необходимо текст вопроса';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Отменить',
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 10),
              CustomButton(
                text: isCreate() ? 'Создать' : 'Обновить',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isCreate()) {
                      var result = QuestionDto(text: _text!, options: []);
                      Navigator.pop(context, result);
                    } else {
                      widget.question?.text = _text!;
                      Navigator.pop(context, widget.question);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OptionDialog extends StatefulWidget {
  final OptionDto? option;

  const OptionDialog({super.key, this.option});

  @override
  _OptionDialogState createState() => _OptionDialogState();
}

class _OptionDialogState extends State<OptionDialog> {
  final _formKey = GlobalKey<FormState>();
  bool? _correct = false;
  String? _text;

  bool isCreate() {
    return widget.option == null;
  }

  @override
  void initState() {
    super.initState();
    if (!isCreate()) {
      _text = widget.option?.text;
      _correct = widget.option?.correct;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                child: TextFormField(
                  decoration: CustomColors.getTextFormInputDecoration(
                    'Текст ответа *',
                    null,
                    context,
                    true,
                  ),
                  style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Необходимо текст ответа';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
                child: Checkbox(
                  value: _correct,
                  activeColor: CustomColors.getPrimary(context),
                  onChanged: (bool? value) {
                    setState(() {
                      _correct = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'Отменить',
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 10),
              CustomButton(
                text: isCreate() ? 'Создать' : 'Обновить',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isCreate()) {
                      var result = OptionDto(text: _text!, correct: _correct!);
                      Navigator.pop(context, result);
                    } else {
                      widget.option?.text = _text!;
                      widget.option?.correct = _correct!;
                      Navigator.pop(context, widget.option);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
