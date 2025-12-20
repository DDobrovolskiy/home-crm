import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';

import '../../../theme/theme.dart';
import '../../support/components/button/hovered_region.dart';
import '../../support/components/callback/NavBarCallBack.dart';
import '../../support/components/label/label_page.dart';
import '../../support/components/load/custom_load.dart';
import '../../support/components/scope/check_scope.dart';
import '../../support/components/screen/Screen.dart';
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
  Widget? _sidePanel;
  bool showSidePanel = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return CustomLoad.load(GetIt.I.get<EducationStore>().getAll(), (
      BuildContext context,
      tests,
    ) {
      return Row(
        children: [
          Expanded(child: _table(context, tests)),
          if (showSidePanel && tests.isNotEmpty)
            SizedBox(
              width: 700,
              child:
                  _sidePanel ??
                  TestDialog(key: Key(tests[0].name), test: tests[0]),
            ),
        ],
      );
    });
  }

  Widget _table(BuildContext context, List<TestAggregate> tests) {
    return Column(
      children: [
        CustomLabelPage(
          contents: [
            IconButton(
              onPressed: () async {
                GetIt.I.get<SheetElementAddCallback>().call(
                  TestDialog(test: TestAggregate()),
                );
              },
              color: CustomColors.getPrimary(context),
              icon: Icon(
                Icons.add_circle,
                size: Screen.isWeb(context) ? 44 : 22,
              ),
            ),
            IconButton(
              onPressed: () async {
                GetIt.I.get<EducationStore>().refresh(Loaded.force);
              },
              color: CustomColors.getSecondaryText(context),
              icon: Icon(
                Icons.refresh_sharp,
                size: Screen.isWeb(context) ? 44 : 22,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
              child: Text(
                widget.getName(),
                textAlign: TextAlign.start,
                style: Screen.isWeb(context)
                    ? CustomColors.getDisplaySmall(context, null)
                    : CustomColors.getDisplaySmallButtonIsWeb(context, null),
              ),
            ),
          ],
        ),
        CustomTable(
          head: CustomTableHeadRow(
            cells: [
              CustomTableHeadRowCell(
                flex: 2,
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
                flex: 2,
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
                      setState(() {
                        _sidePanel = TestDialog(
                          key: Key(test.name),
                          test: test,
                        );
                      });

                      // GetIt.I.get<SheetElementAddCallback>().call(
                      //   TestDialog(test: test),
                      // );
                    },
                  ).checkScope(ScopeType.TEST_CREATE, context);
                },
                child: (isHovered) {
                  return CustomTableRow(
                    hover: isHovered,
                    cells: [
                      CustomTableRowCellText(
                        flex: 2,
                        text: test.getNumber(),
                        textVisibleAlways: true,
                        subText: test.name,
                        subTextVisibleAlways: true,
                      ),
                      CustomTableRowCell(
                        body: FittedBox(
                          child: Row(
                            children: [CustomStatusDoc(status: test.status)],
                          ),
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
                        flex: 2,
                        textVisibleAlways: true,
                        body: Column(
                          children: [
                            for (final appoint in test.appointed)
                              FittedBox(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsGeometry.symmetric(
                                        vertical: 2,
                                      ),
                                      child: CustomLoad.load(
                                        appoint.getEmployee(),
                                        (context, emp) {
                                          return Row(
                                            children: [
                                              Text(
                                                '${emp?.user.name}',
                                                style:
                                                    CustomColors.getLabelMedium(
                                                      context,
                                                      null,
                                                    ),
                                              ),
                                              CustomLoad.load(emp!.getRole(), (
                                                BuildContext context,
                                                role,
                                              ) {
                                                return Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.symmetric(
                                                        horizontal: 2,
                                                      ),
                                                  child: Text(
                                                    '[${role?.name}]',
                                                    style:
                                                        CustomColors.getLabelSmall(
                                                          context,
                                                          null,
                                                        ),
                                                  ),
                                                );
                                              }),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    if (Screen.isWeb(context))
                                      Padding(
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                              horizontal: 2,
                                            ),
                                        child: CustomStatusDoc(
                                          status: appoint.isStatus(
                                            test.iteration,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
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
