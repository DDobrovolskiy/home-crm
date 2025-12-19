import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomLoad.load(GetIt.I.get<EducationStore>().getAll(), (tests) {
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
                  text: 'Номер',
                  textVisibleAlways: true,
                  subText: 'Название',
                  subTextVisibleAlways: true,
                ),
                CustomTableHeadRowCell(text: 'Статус', textVisibleAlways: true),
                CustomTableHeadRowCell(
                  text: 'Кол-во вопросов',
                  subText: 'Необходимое кол-во правильных ответов',
                  subTextVisibleAlways: true,
                ),
                CustomTableHeadRowCell(
                  text: 'Ограничение по времени (мин.)',
                  subText: 'Кол-во попыток',
                  subTextVisibleAlways: true,
                ),
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
                        GetIt.I.get<SheetElementAddCallback>().call(
                          TestDialog(test: test),
                        );
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
                          body: Row(
                            children: [CustomStatusDoc(status: test.status)],
                          ),
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
    });
  }
}
