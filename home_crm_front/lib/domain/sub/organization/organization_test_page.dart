import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/test/cubit/test_assign.dart';
import 'package:home_crm_front/domain/sub/education/test/widget/test_dialog.dart';
import 'package:home_crm_front/domain/sub/employee/widget/employee_tooltip.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_test_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_test_event.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_test_state.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_test_state.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/components/button/hovered_region.dart';
import '../../support/components/scope/check_scope.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';
import '../../support/widgets/stamp.dart';
import '../education/result/dto/response/result_dto.dart';
import '../education/test/bloc/test_edit_bloc.dart';
import '../education/test/event/test_edit_event.dart';
import '../scope/scope.dart';
import 'bloc/organization_test_bloc.dart';
import 'event/organization_test_event.dart';

class OrganizationTestsWrapper extends StatelessWidget {
  const OrganizationTestsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return OrganizationTestsPage();
  }
}

@RoutePage()
class OrganizationTestsPage extends StatefulWidget {
  const OrganizationTestsPage({super.key});

  @override
  _OrganizationTestsPageState createState() => _OrganizationTestsPageState();
}

class _OrganizationTestsPageState extends State<OrganizationTestsPage> {
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();
  final textController = TextEditingController(); // Контроллер для поля ввода
  final formKey = GlobalKey<FormState>(); // Глобальный ключ формы для валидации

  @override
  void initState() {
    BlocProvider.of<OrganizationTestBloc>(
      context,
    ).add(OrganizationTestRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationTestBloc, OrganizationTestState>(
      listener: (context, state) {
        if (state is OrganizationTestErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        return getContent(context, state);
      },
    );
  }

  Widget getContent(BuildContext context, OrganizationTestState state) {
    if (!state.loaded()) {
      return Stamp.loadWidget(context);
    } else if (state.getBody() != null) {
      return Column(
        children: [
          // Padding(
          //   padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
          //   child: Text(
          //     'Тесты',
          //     textAlign: TextAlign.start,
          //     style: CustomColors.getDisplaySmall(context, null),
          //   ),
          // ),
          CustomTable(
            head: CustomTableHeadRow(
              cells: [
                CustomTableHeadRowCell(
                  text: 'Название',
                  textVisibleAlways: true,
                  subText: 'Статус',
                ),
                CustomTableHeadRowCell(text: 'Статус'),
                CustomTableHeadRowCell(text: 'Ограничение по времени (мин.)'),
                CustomTableHeadRowCell(
                  text: 'Назначен',
                  textVisibleAlways: true,
                  subText: 'Проходят',
                  subTextVisibleAlways: true,
                ),
              ],
            ),
            rows: [
              for (final test in state.getBody()!.tests)
                HoveredRegion(
                  onTap: () async {
                    CheckScope(
                      onTrue: () {
                        TestDialog.show(context, test.test);
                      },
                    ).checkScope(ScopeType.TEST_CREATE, context);
                  },
                  child: (isHovered) {
                    return CustomTableRow(
                      hover: isHovered,
                      cells: [
                        CustomTableRowCellText(
                          text: test.test.name,
                          textVisibleAlways: true,
                          subText: test.test.ready ? 'Готов' : 'В работе',
                          icon: test.test.ready
                              ? Icon(Icons.done)
                              : Icon(Icons.play_arrow),
                        ),
                        CustomTableRowCellText(
                          text: test.test.ready ? 'Готов' : 'В работе',
                        ),
                        CustomTableRowCellText(
                          text: test.test.timeLimitMinutes == 0
                              ? 'Нет'
                              : test.test.timeLimitMinutes.toString(),
                        ),
                        CustomTableRowCell(
                          textVisibleAlways: true,
                          body: Column(
                            children: [
                              for (final employee
                              in test.testEmployees.employees)
                                EmployeeTooltip(employee: employee),
                              if (test.testSessions.sessions.isNotEmpty)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    2,
                                    0,
                                    0,
                                  ),
                                  child: Text(
                                    'Проходят тестирование:',
                                    style: CustomColors.getLabelSmall(
                                      context,
                                      null,
                                    ),
                                  ),
                                ),
                              for (final session
                              in test.testSessions.sessions)
                                EmployeeTooltip(
                                  employee: session.employee,
                                  style: CustomColors.getLabelSmall(
                                    context,
                                    null,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              if (organizationCurrentService.isEditor(ScopeType.TEST_CREATE))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          TestDialog.show(context, null);
                        },
                        color: CustomColors.getSecondaryText(context),
                        icon: Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // for (final test in state.organization!.tests)
          //   Card(
          //     margin: const EdgeInsets.all(8),
          //     child: ListTile(
          //       leading: Icon(Icons.text_snippet_rounded),
          //       title: Text(test.test.name),
          //       subtitle: Column(
          //         children: [
          //           Row(
          //             children: [
          //               test.test.ready
          //                   ? Icon(Icons.done)
          //                   : Icon(Icons.play_arrow),
          //               test.test.ready
          //                   ? Text('(Тест готов)')
          //                   : Text('(Тест в процессе создания)'),
          //               ?delete(context, test, state),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text('Ограничение по времени (мин.): '),
          //               test.test.timeLimitMinutes == 0
          //                   ? Text('нет')
          //                   : Text(test.test.timeLimitMinutes.toString()),
          //             ],
          //           ),
          //           if (state.hasEdit)
          //             OutlinedButton.icon(
          //               // Добавили кнопку с иконкой
          //               icon: Icon(Icons.add_circle),
          //               label: Text("Назначить"),
          //               onPressed: () {
          //                 openAddTestDialog(test.test.id);
          //               },
          //             ),
          //           Text(
          //             'Тест назначен сотрудникам:',
          //             textAlign: TextAlign.left,
          //           ),
          //           Column(
          //             children: [
          //               for (final employee in test.testEmployees.employees)
          //                 Stamp.giperLinkText(
          //                   Text(employee.user.name, textAlign: TextAlign.left),
          //                   () {
          //                     // AutoRouter.of(
          //                     //   context,
          //                     // ).push(EmployeeRoute(employeeId: employee.id));
          //                   },
          //                 ),
          //             ],
          //           ),
          //           Text(
          //             'Следующие сотрудники проходят тест:',
          //             textAlign: TextAlign.left,
          //           ),
          //           Column(
          //             children: [
          //               for (final session in test.testSessions.sessions)
          //                 if (session.active)
          //                   Text(
          //                     session.employee.user.name,
          //                     textAlign: TextAlign.left,
          //                   ),
          //             ],
          //           ),
          //           Text('Результаты тестирования:', textAlign: TextAlign.left),
          //           Column(
          //             children: [
          //               for (final result in test.testResults)
          //                 Row(
          //                   children: [
          //                     Text(
          //                       result.session.employee.user.name,
          //                       textAlign: TextAlign.left,
          //                     ),
          //                     Text(
          //                       ' Правильных ответов: ${result.details.where((d) => d.isCorrect).length} из ${result.details.length}',
          //                     ),
          //                   ],
          //                 ),
          //             ],
          //           ),
          //         ],
          //       ),
          //       trailing: edit(context, test, state),
          //     ),
          //   ),

        ],
      );
    } else {
      return Stamp.errorWidget(context);
    }
  }

  Widget? _tableResult(List<ResultDto> testResults) {
    if (testResults.isNotEmpty) {
      return Column(
        children: [
        ],
      );
    }
    return null;
  }


  void openAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Добавить новый тест'),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: textController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Название теста не должно быть пустым!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Введите название теста',
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
                            GetIt.I.get<TestEditBloc>().add(
                              TestEditCreateEvent(name: enteredName),
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

  void openAddTestDialog(int testId) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogWidget(testId: testId);
      },
    );
  }
}

// Виджет с внутренним состоянием для диалога
class CustomDialogWidget extends StatefulWidget {
  final int testId;

  const CustomDialogWidget({super.key, required this.testId});

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  void initState() {
    GetIt.I.get<OrganizationEmployeeTestBloc>().add(
      OrganizationEmployeeTestRefreshEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      OrganizationEmployeeTestBloc,
      OrganizationEmployeeTestState
    >(
      listener: (context, state) {},
      builder: (context, state) {
        if (!state.loaded) {
          return Stamp.loadWidget(context);
        } else {
          return SimpleDialog(
            title: Text('Назначить тест'),
            children: [
              Form(
                child: Column(
                  children: [
                    for (final employee in state.organization!.employees)
                      Row(
                        children: [
                          Stamp.giperLinkText(
                            Text(
                              employee.employee.user.name,
                              textAlign: TextAlign.left,
                            ),
                            () {
                              // AutoRouter.of(context).push(
                              //   EmployeeRoute(employeeId: employee.employee.id),
                              // );
                            },
                          ),
                          Spacer(),
                          Text('Назначен: '),
                          Checkbox(
                            value: employee.employeeTests.tests.any(
                              (test) => test.id == widget.testId,
                            ),
                            onChanged: (bool? value) {
                              if (employee.employeeTests.tests.any(
                                (test) => test.id == widget.testId,
                              )) {
                                GetIt.I.get<TestAssignCubit>().unassignTest(
                                  widget.testId,
                                  employee.employee.id,
                                );
                              } else {
                                GetIt.I.get<TestAssignCubit>().assignTest(
                                  widget.testId,
                                  employee.employee.id,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Назад'),
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
}
