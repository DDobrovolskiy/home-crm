import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/appointed_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/option_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/question_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/session_aggregate.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';

import '../../support/components/button/hovered_region.dart';
import '../../support/components/callback/NavBarCallBack.dart';
import '../../support/components/label/label_page.dart';
import '../../support/components/load/custom_load.dart';
import '../../support/components/scope/check_scope.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';
import '../scope/scope.dart';
import 'aggregate/test_aggregate.dart';
import 'widget/test_dialog.dart';

@RoutePage()
class OrganizationTestsPage extends SheetPage {
  static String name = 'Тесты';

  const OrganizationTestsPage({super.key});

  @override
  String getName() {
    return name;
  }

  @override
  _OrganizationTestsPageState createState() => _OrganizationTestsPageState();
}

class _OrganizationTestsPageState extends State<OrganizationTestsPage>
    with AutomaticKeepAliveClientMixin<OrganizationTestsPage> {
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();

  List<TestAggregate> tests = [
    TestAggregate(
      id: 1,
      name: 'Охрана труда',
      description: 'Вопросы по охране труда',
      status: StatusDoc.READY,
      timeLimitMinutes: 20,
      iteration: 3,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
      appointed: [
        AppointedAggregate(
          employeeId: 11,
          deadline: DateTime.now(),
          sessions: [
            SessionAggregate(
              id: 1,
              dateStart: DateTime.now(),
              dateEnd: DateTime.now().add(Duration(minutes: 20)),
              success: false,
              answers: 0,
            ),
          ],
        ),
        AppointedAggregate(
          employeeId: 13,
          deadline: DateTime.now(),
          sessions: [],
        ),
      ],
    ),
    TestAggregate(
      id: 2,
      name: 'Пожарная безопасность',
      description: 'Вопросы по пожарнаой безопасность',
      status: StatusDoc.DRAFT,
      timeLimitMinutes: 0,
      iteration: 0,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
    ),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // BlocProvider.of<OrganizationTestBloc>(
    //   context,
    // ).add(OrganizationTestRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        LabelPage(
          text: OrganizationTestsPage.name,
          onAdd: () async {
            GetIt.I.get<SheetElementAddCallback>().call(
              TestDialog(test: TestAggregate()),
            );
          },
        ),
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
            for (final test in tests)
              HoveredRegion(
                onTap: () async {
                  CheckScope(
                    onTrue: () {
                      // TestDialog.show(context, test.test);
                    },
                  ).checkScope(ScopeType.TEST_CREATE, context);
                },
                child: (isHovered) {
                  return CustomTableRow(
                    hover: isHovered,
                    cells: [
                      CustomTableRowCellText(
                        text: test.getNumber(),
                        textVisibleAlways: true,
                        subText: test.name,
                        subTextVisibleAlways: true,
                      ),
                      CustomTableRowCell(
                        body: CustomStatusDoc(status: test.status),
                        textVisibleAlways: true,
                      ),
                      CustomTableRowCellText(
                        text: test.questions.length.toString(),
                        subText: test.answerCount.toString(),
                        subTextVisibleAlways: true,
                      ),
                      CustomTableRowCellText(
                        text: test.timeLimitMinutes == 0
                            ? 'Нет'
                            : test.timeLimitMinutes.toString(),
                        subText: test.iteration == 0
                            ? 'Без ограничений'
                            : test.iteration.toString(),
                        subTextVisibleAlways: true,
                      ),
                      CustomTableRowCell(
                        textVisibleAlways: true,
                        body: Column(
                          children: [
                            for (final appoint in test.appointed)
                              CustomLoad.load(appoint.getEmployee(), (emp) {
                                return Text(emp?.userId.toString() ?? '');
                              }),

                            // EmployeeTooltip(employee: employee),
                            // if (test..sessions.isNotEmpty)
                            //   Padding(
                            //     padding: EdgeInsetsDirectional.fromSTEB(
                            //       0,
                            //       2,
                            //       0,
                            //       0,
                            //     ),
                            //     child: Text(
                            //       'Проходят тестирование:',
                            //       style: CustomColors.getLabelSmall(
                            //         context,
                            //         null,
                            //       ),
                            //     ),
                            //   ),
                            // for (final session in test.testSessions.sessions)
                            //   EmployeeTooltip(
                            //     employee: session.employee,
                            //     style: CustomColors.getLabelSmall(
                            //       context,
                            //       null,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
