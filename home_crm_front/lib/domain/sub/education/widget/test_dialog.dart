import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/option_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/question_aggregate.dart';
import 'package:home_crm_front/domain/support/components/label/label_page.dart';
import 'package:home_crm_front/domain/support/components/pattern/pattern.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../../support/components/button/hovered_region.dart';
import '../../../support/components/calendar/custom_calendar.dart';
import '../../../support/components/callback/NavBarCallBack.dart';
import '../../../support/components/dialog/custom_dialog.dart';
import '../../../support/components/load/custom_load.dart';
import '../../../support/components/screen/Screen.dart';
import '../../../support/components/status/doc.dart';
import '../../../support/components/tab/custom_tab.dart';
import '../../../support/components/table/table.dart';
import '../../../support/components/table/table_head_row.dart';
import '../../../support/components/table/table_head_row_cell.dart';
import '../../../support/components/table/table_row.dart';
import '../../../support/components/table/table_row_cell.dart';
import '../../employee/widget/employee_select.dart';
import '../aggregate/appointed_aggregate.dart';
import '../aggregate/test_aggregate.dart';
import '../store/education_store.dart';

class TestDialog extends SheetPage {
  @override
  String getName() {
    return test.getNumber();
  }

  final TestAggregate test;
  final bool isSidePanel;

  const TestDialog({super.key, required this.test, this.isSidePanel = false});

  @override
  _TestDialogState createState() => _TestDialogState();
}

class _TestDialogState extends State<TestDialog> {
  late TestAggregate test;
  late TextEditingController _controllerMinute;
  late TextEditingController _controllerIteration;

  @override
  void initState() {
    super.initState();
    test = widget.test.copy();
    _controllerMinute = TextEditingController(
      text: test.timeLimitMinutes.toString(),
    );
    _controllerIteration = TextEditingController(
      text: test.iteration.toString(),
    );
  }

  @override
  void dispose() {
    _controllerMinute.dispose();
    _controllerIteration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogPage(
      label: (validator) {
        return Column(
          children: [
            CustomLabelPage(
              contents: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.isSidePanel)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
                            child: CustomButtonDisplay(
                              primary: true,
                              text: 'Утвердить и закрыть',
                              onPressed: () async {
                                if (validator()) {
                                  var error = test.doReady();
                                  if (error != null) {
                                    Stamp.showTemporarySnackbar(context, error);
                                  } else {
                                    GetIt.I.get<EducationStore>().save([test]);
                                    GetIt.I
                                        .get<SheetElementDeleteCallback>()
                                        .call(widget.getName());
                                    setState(() {});
                                  }
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
                            child: IconButton(
                              onPressed: () async {
                                GetIt.I.get<EducationStore>().save([test]);
                              },
                              color: CustomColors.getSecondaryText(context),
                              tooltip: 'Сохранить',
                              icon: Icon(
                                Icons.save,
                                size: Screen.isWeb(context) ? 44 : 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: [
                        if (widget.isSidePanel)
                          Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
                            child: IconButton(
                              onPressed: () async {
                                GetIt.I.get<EducationStore>().save([test]);
                              },
                              color: CustomColors.getSecondaryText(context),
                              tooltip: 'Сохранить',
                              icon: Icon(
                                Icons.save,
                                size: Screen.isWeb(context) ? 44 : 22,
                              ),
                            ),
                          ),
                        Text(
                          widget.getName(),
                          textAlign: TextAlign.start,
                          style: Screen.isWeb(context)
                              ? CustomColors.getDisplaySmall(context, null)
                              : CustomColors.getDisplaySmallButtonIsWeb(
                                  context,
                                  null,
                                ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          child: CustomStatusDocChange<TestAggregate>(
                            init: test.status,
                            map: test.statuses,
                            onChanged:
                                (
                                  MapEntry<
                                    StatusDoc,
                                    String? Function(TestAggregate)
                                  >?
                                  value,
                                ) {
                                  var s = value?.value(test);
                                  if (s != null) {
                                    Stamp.showTemporarySnackbar(context, s);
                                  } else {
                                    setState(() {
                                      GetIt.I.get<EducationStore>().save([
                                        test,
                                      ]);
                                    });
                                  }
                                },
                          ),
                        ),
                      ],
                    ),
                  ],
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
          label: () => test.questions.length,
        ),
        (key) => CustomTabView(
          name: 'Сотрудники',
          child: appointed(key),
          label: () => test.appointed.length,
        ),
      ],
    );
  }

  Widget main(GlobalKey<FormState> _formKeyTab) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(4, 16, 2, 2),
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
                      readOnly: test.status.ready,
                      onTap: () async {
                        if (await test.isReady(context)) {
                          setState(() {});
                        }
                      },
                      style: CustomColors.getBodyMedium(context, null),
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: test.getName(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Необходимо ввести название теста';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          test.name = value;
                        });
                      },
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
                            inputFormatters: [Format.numberFormatter3],
                            controller: _controllerMinute,
                            readOnly: test.status.ready,
                            onTap: () async {
                              if (await test.isReady(context)) {
                                setState(() {});
                              }
                            },
                            style: CustomColors.getBodyMedium(context, null),
                            maxLines: null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value != null &&
                                  (int.tryParse(value) == null ||
                                      int.tryParse(value)! > 1000)) {
                                return 'Необходимо ввести число до 1000';
                              } else if (value == null) {
                                return 'Необходимо ввести выполнениния в минутах';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                test.timeLimitMinutes =
                                    int.tryParse(value) ?? 0;
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
                                value: test.timeLimitMinutes == 0,
                                activeColor: CustomColors.getPrimary(context),
                                onChanged: (bool? value) async {
                                  if (await test.isReady(context)) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          test.timeLimitMinutes = 0;
                                          _controllerMinute.value =
                                              TextEditingValue(
                                                text: test.timeLimitMinutes
                                                    .toString(),
                                              );
                                        }
                                      }
                                    });
                                  }
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
                            inputFormatters: [Format.numberFormatter2],
                            controller: _controllerIteration,
                            readOnly: test.status.ready,
                            onTap: () async {
                              if (await test.isReady(context)) {
                                setState(() {});
                              }
                            },
                            style: CustomColors.getBodyMedium(context, null),
                            maxLines: null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // initialValue: test.iteration.toString(),
                            validator: (value) {
                              if (value != null &&
                                  (int.tryParse(value) == null ||
                                      int.tryParse(value)! > 100)) {
                                return 'Необходимо ввести число до 100';
                              } else if (value == null) {
                                return 'Необходимо ввести количество попыток';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                test.iteration = int.tryParse(value) ?? 0;
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
                                value: test.iteration == 0,
                                activeColor: CustomColors.getPrimary(context),
                                onChanged: (bool? value) async {
                                  if (await test.isReady(context)) {
                                    setState(() {
                                      if (value != null) {
                                        if (value) {
                                          test.iteration = 0;
                                          _controllerIteration.value =
                                              TextEditingValue(
                                                text: test.iteration.toString(),
                                              );
                                        }
                                      }
                                    });
                                  }
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
                        'Необходимое кол-во правильных ответов (из ${test.questions.length} вопросов) *',
                        null,
                        context,
                        true,
                      ),
                      inputFormatters: [Format.numberFormatter3],
                      readOnly: test.status.ready,
                      onTap: () async {
                        if (await test.isReady(context)) {
                          setState(() {});
                        }
                      },
                      style: CustomColors.getBodyMedium(context, null),
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: test.answerCount.toString(),
                      validator: (value) {
                        if (value != null &&
                            (int.tryParse(value) == null ||
                                int.tryParse(value)! > test.questions.length)) {
                          return 'Необходимо ввести число до ${test.questions.length}';
                        } else if (value == null) {
                          return 'Необходимое кол-во правильных ответов (из ${test.questions.length} вопросов)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          test.answerCount = int.tryParse(value) ?? 0;
                        });
                      },
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
                      initialValue: test.description,
                      validator: (value) {
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          test.description = value;
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
      padding: EdgeInsetsDirectional.fromSTEB(4, 16, 2, 2),
      child: Form(
        key: _formKeyTab,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(children: [tableQuestions(test.questions)]),
      ),
    );
  }

  Widget tableQuestions(List<QuestionAggregate> questions) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          IconButton(
            onPressed: () async {
              if (await test.isReady(context)) {
                setState(() {
                  test.questions.clear();
                });
              }
            },
            color: CustomColors.getSecondaryText(context),
            icon: Icon(Icons.delete),
          ),
          if (Screen.isWeb(context))
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
              child: Text(
                '№',
                style: CustomColors.getLabelMedium(context, null),
              ),
            ),
          CustomTableHeadRowCell(
            flex: 3,
            text: 'Вопрос',
            textVisibleAlways: true,
            subText: 'Ответы',
          ),
          CustomTableHeadRowCell(
            flex: 4,
            text: 'Ответы',
            textVisibleAlways: false,
          ),
        ],
      ),
      rows: [
        for (int i = 0; i < test.questions.length; i++)
          CustomTableRow(
            error: test.questions[i].getError(),
            cells: [
              IconButton(
                onPressed: () async {
                  if (await test.isReady(context)) {
                    setState(() {
                      test.questions.removeAt(i);
                    });
                  }
                },
                color: CustomColors.getSecondaryText(context),
                icon: Icon(Icons.delete_outline),
              ),
              if (Screen.isWeb(context))
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                  child: Text(
                    (i + 1).toString(),
                    style: CustomColors.getBodyLarge(context, null),
                  ),
                ),
              CustomTableRowCell(
                flex: 3,
                textVisibleAlways: true,
                body: TextFormField(
                  decoration: CustomColors.getTextFormInputDecoration(
                    Screen.isWeb(context)
                        ? 'Вопрос'
                        : 'Вопрос №${(i + 1).toString()}',
                    null,
                    context,
                    true,
                  ),
                  readOnly: test.status.ready,
                  onTap: () async {
                    if (await test.isReady(context)) {
                      setState(() {});
                    }
                  },
                  style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: test.questions[i].text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Необходимо ввести текст вопроса';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      test.questions[i].text = value;
                    });
                  },
                ),
                subBody: Column(
                  children: [tableOptions(test.questions[i].options)],
                ),
              ),
              CustomTableRowCell(
                flex: 4,
                textVisibleAlways: false,
                body: Column(
                  children: [tableOptions(test.questions[i].options)],
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
                  if (await test.isReady(context)) {
                    setState(() {
                      test.questions.add(QuestionAggregate());
                    });
                  }
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

  Widget tableOptions(List<OptionAggregate> options) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          IconButton(
            onPressed: () async {
              if (await test.isReady(context)) {
                setState(() {
                  options.clear();
                });
              }
            },
            color: CustomColors.getSecondaryText(context),
            icon: Icon(Icons.delete),
          ),
          if (Screen.isWeb(context))
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
              child: Text(
                '№',
                style: CustomColors.getLabelMedium(context, null),
              ),
            ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
            child: SizedBox(
              width: 55,
              child: Text(
                'Верный ответ',
                textAlign: TextAlign.center,
                style: CustomColors.getLabelMedium(context, null),
              ),
            ),
          ),
          // CustomTableHeadRowCell(text: 'Верный ответ', textVisibleAlways: true),
          CustomTableHeadRowCell(
            flex: 5,
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
                  if (await test.isReady(context)) {
                    setState(() {
                      options.removeAt(o);
                    });
                  }
                },
                color: CustomColors.getSecondaryText(context),
                icon: Icon(Icons.delete_outline),
              ),
              if (Screen.isWeb(context))
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                  child: Text(
                    (o + 1).toString(),
                    style: CustomColors.getLabelMedium(context, null),
                  ),
                ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                child: SizedBox(
                  width: 55,
                  child: Align(
                    alignment: Alignment.center,
                    child: Checkbox(
                      value: options[o].correct,
                      activeColor: CustomColors.getPrimary(context),
                      onChanged: test.status.ready
                          ? null
                          : (bool? value) {
                              setState(() {
                                options[o].correct = !options[o].correct;
                              });
                            },
                    ),
                  ),
                ),
              ),
              CustomTableRowCell(
                flex: 5,
                textVisibleAlways: true,
                body: TextFormField(
                  decoration: CustomColors.getTextFormInputDecoration(
                    Screen.isWeb(context)
                        ? 'Ответ'
                        : 'Ответ №${(o + 1).toString()}',
                    null,
                    context,
                    true,
                  ),
                  readOnly: test.status.ready,
                  onTap: () async {
                    if (test.status.ready) {
                      if (await showStausAlertDialog(
                            test.status,
                            StatusDoc.DRAFT,
                            context,
                          ) ??
                          false) {
                        setState(() {
                          test.doDraft();
                        });
                      }
                    }
                  },
                  style: CustomColors.getBodyMedium(context, null),
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.always,
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
                  if (await test.isReady(context)) {
                    setState(() {
                      options.add(OptionAggregate());
                    });
                  }
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

  Widget appointed(GlobalKey<FormState> _formKeyTab) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(4, 16, 2, 2),
      child: Form(
        key: _formKeyTab,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [tableAppointed(test.appointed, test.iteration)],
        ),
      ),
    );
  }

  Widget tableAppointed(List<AppointedAggregate> appointed, int iteration) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          IconButton(
            onPressed: () async {
              setState(() {
                appointed.clear();
              });
            },
            color: CustomColors.getSecondaryText(context),
            icon: Icon(Icons.delete),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
            child: Text('№', style: CustomColors.getLabelMedium(context, null)),
          ),
          CustomTableHeadRowCell(
            flex: 2,
            text: 'Сотрудник',
            textVisibleAlways: true,
            subText: 'Роль',
            subTextVisibleAlways: true,
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 10),
              child: Row(
                children: [
                  CustomButton(
                    text: 'Выполнить до',
                    onPressed: () {
                      CustomCalendar.showSingleDate(
                        context,
                        null,
                        (arg) {
                          setState(() {
                            appointed.forEach(
                              (i) => i.deadline = arg as DateTime?,
                            );
                          });
                          Navigator.pop(context);
                        },
                        () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomTableHeadRowCell(
            flex: 1,
            text: 'Кол-во попыток',
            subText: 'Осталось попыток',
            subTextVisibleAlways: true,
          ),
          CustomTableHeadRowCell(
            flex: 1,
            text: 'Статус',
            textVisibleAlways: true,
          ),
        ],
      ),
      rows: [
        for (int i = 0; i < appointed.length; i++)
          HoveredRegion(
            onTap: () async {},
            child: (isHovered) {
              return CustomTableRow(
                hover: isHovered,
                cells: [
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        appointed.removeAt(i);
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
                  CustomLoad.load(appointed[i].getEmployee(), (context, emp) {
                    return CustomLoad.load(emp!.getRole(), (
                      BuildContext context,
                      role,
                    ) {
                      return CustomTableRowCellText(
                        flex: 2,
                        text: emp.user.name,
                        textVisibleAlways: true,
                        subText: role?.name,
                        subTextVisibleAlways: true,
                      );
                    });
                  }),
                  CustomTableRowCell(
                    flex: 2,
                    textVisibleAlways: true,
                    body: Row(
                      children: [
                        CustomButton(
                          text: appointed[i].deadline == null
                              ? 'Нет'
                              : DateFormat(
                                  'yyyy-MM-dd',
                                ).format(appointed[i].deadline!),
                          onPressed: () {
                            CustomCalendar.showSingleDate(
                              context,
                              appointed[i].deadline,
                              (arg) {
                                setState(() {
                                  appointed[i].deadline = arg as DateTime?;
                                });
                                Navigator.pop(context);
                              },
                              () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  CustomTableRowCellText(
                    flex: 1,
                    text: appointed[i].getAttempts().toString(),
                    subTextVisibleAlways: true,
                    subText: (iteration - appointed[i].getAttempts())
                        .toString(),
                  ),
                  CustomTableRowCell(
                    flex: 1,
                    textVisibleAlways: true,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomStatusDoc(
                          status: appointed[i].isStatus(iteration),
                        ),
                        const SizedBox(height: 2),
                        CustomStatusDoc(status: appointed[i].isActive()),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
          child: Row(
            children: [
              EmployeeSelect(
                saveSelected: false,
                text: 'Добавить сотрудника',
                excludeId: test.appointed.map((t) => t.employeeId).toSet(),
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 60,
                  width: 250,
                ),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    test.addAppointed(
                      AppointedAggregate(
                        employeeId: value!.id,
                        testId: test.id,
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
