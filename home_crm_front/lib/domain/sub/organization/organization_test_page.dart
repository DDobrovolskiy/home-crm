import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/widget/employee_tooltip.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_test_state.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/components/button/hovered_region.dart';
import '../../support/components/callback/NavBarCallBack.dart';
import '../../support/components/label/label_page.dart';
import '../../support/components/scope/check_scope.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';
import '../../support/widgets/stamp.dart';
import '../education/aggregate/test_aggregate.dart';
import '../education/widget/test_dialog.dart';
import '../scope/scope.dart';
import 'bloc/organization_test_bloc.dart';
import 'event/organization_test_event.dart';

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
  final textController = TextEditingController(); // Контроллер для поля ввода
  final formKey = GlobalKey<FormState>(); // Глобальный ключ формы для валидации

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    BlocProvider.of<OrganizationTestBloc>(
      context,
    ).add(OrganizationTestRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              for (final test in state.getBody()!.tests)
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
                          text: test.test.name,
                          textVisibleAlways: true,
                        ),
                        CustomTableRowCell(
                          body: CustomStatusDoc(status: StatusDoc.DRAFT),
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
                              for (final session in test.testSessions.sessions)
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
            ],
          ),
        ],
      );
    } else {
      return Stamp.errorWidget(context);
    }
  }
}

