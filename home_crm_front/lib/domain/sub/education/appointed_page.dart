import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/appointed_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/store/appointed_store.dart';
import 'package:home_crm_front/domain/sub/education/widget/appointed_dialog.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';
import '../../support/components/button/hovered_region.dart';
import '../../support/components/callback/NavBarCallBack.dart';
import '../../support/components/label/label_page.dart';
import '../../support/components/load/custom_load.dart';
import '../../support/components/screen/Screen.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';

class AppointedPage extends SheetPage {
  static String name = 'Контроль знаний';

  const AppointedPage({super.key});

  @override
  String getName() {
    return name;
  }

  @override
  _AppointedPageState createState() => _AppointedPageState();
}

class _AppointedPageState extends State<AppointedPage>
    with AutomaticKeepAliveClientMixin<AppointedPage> {
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();
  int? _idSidePanel;
  bool showSidePanel = true;
  Set<int> selectIds = {};
  bool showDone = false;
  bool showNotActive = false;

  AppointedDialog create(Map<int, AppointedAggregate> appointedMap,
      int? id, {
        bool isSidePanel = false,
      }) {
    if (appointedMap.containsKey(id)) {
      return AppointedDialog(
          key: appointedMap[id]!.getKey(),
          appointed: appointedMap[id]!
      );
    }
    var first = appointedMap.keys.first;
    return AppointedDialog(
      key: appointedMap[first]!.getKey(),
      appointed: appointedMap[first]!,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return CustomLoad.load(GetIt.I.get<AppointedStore>().getAllMap(), (
      BuildContext context,
        appointedMap,
    ) {
      return Row(
        children: [
          Expanded(child: _table(context, appointedMap)),
          if (appointedMap.isNotEmpty && Screen.isSidePanel(context))
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showSidePanel = !showSidePanel;
                      });
                    },
                    icon: Icon(
                      showSidePanel
                          ? Icons.keyboard_double_arrow_right
                          : Icons.keyboard_double_arrow_left,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        GetIt.I.get<SheetElementAddCallback>().call(
                          create(appointedMap, _idSidePanel),
                        );
                      });
                    },
                    icon: Icon(Icons.open_in_browser),
                  ),
                ],
              ),
            ),
          if (showSidePanel &&
              appointedMap.isNotEmpty &&
              Screen.isSidePanel(context))
            SizedBox(
              width: 700,
              child: create(appointedMap, _idSidePanel),
            ),
        ],
      );
    });
  }

  Widget _table(BuildContext context,
      Map<int, AppointedAggregate> appointedMap) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight < 150) {
          return SizedBox.shrink();
        }
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxHeight < 175) {
                  return SizedBox.shrink();
                }
                return CustomLabelPage(
                  contents: [
                    IconButton(
                      onPressed: () async {
                        GetIt.I.get<AppointedStore>().refresh(Loaded.force);
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
                            : CustomColors.getDisplaySmallButtonIsWeb(
                                context,
                                null,
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxHeight < 40) {
                  return SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Checkbox(
                                  value: showDone,
                                  activeColor: CustomColors.getPrimary(context),
                                  onChanged: (bool? value) async {
                                    if (value != null) {
                                      setState(() {
                                        showDone = value;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  'Показать выполненные',
                                  style: CustomColors.getTitleMedium(
                                    context,
                                    null,
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Checkbox(
                                  value: showNotActive,
                                  activeColor: CustomColors.getPrimary(context),
                                  onChanged: (bool? value) async {
                                    if (value != null) {
                                      setState(() {
                                        showNotActive = value;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  'Показать не активные тесты',
                                  style: CustomColors.getTitleMedium(
                                    context,
                                    null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Flexible(
              child: CustomTable(
                head: CustomTableHeadRow(
                  cells: [
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                      child: Text(
                        '№',
                        style: CustomColors.getLabelMedium(context, null),
                      ),
                    ),
                    CustomTableHeadRowCell(
                      flex: 2,
                      text: 'Номер',
                      textVisibleAlways: true,
                      subText: 'Название',
                      subTextVisibleAlways: true,
                    ),
                    CustomTableHeadRowCell(
                      text: 'Статус',
                      textVisibleAlways: true,
                    ),
                    CustomTableHeadRowCell(
                      text: 'Кол-во вопросов',
                      subText: 'Необходимое кол-во правильных ответов',
                      subTextVisibleAlways: true,
                    ),
                    CustomTableHeadRowCell(
                      text: 'Ограничение по времени (мин.)',
                      subText: 'Осталось попыток',
                      subTextVisibleAlways: true,
                    ),
                    CustomTableHeadRowCell(
                      text: 'Дата завершения тестирования',
                      textVisibleAlways: true,
                    ),
                  ],
                ),
                rows: [
                  ...appointedMap.values
                      .where((a) => a.isDone() == false || showDone)
                      .where((a) => a.active || showNotActive)
                      .mapIndexed((index, appoint) {
                    return CustomLoad.load(
                        key: appoint.getKey(), appoint.getTest(), (
                          context,
                          test,
                        ) {
                      if (test == null) {
                        return SizedBox.shrink();
                      }
                          return HoveredRegion(
                            onTap: () async {
                              setState(() {
                                _idSidePanel = appoint.id;
                                if (!Screen.isSidePanel(context)) {
                                  setState(() {
                                    GetIt.I.get<SheetElementAddCallback>().call(
                                        create(appointedMap, _idSidePanel)
                                    );
                                  });
                                }
                              });
                            },
                            child: (isHovered) {
                              return CustomTableRow(
                                hover: isHovered,
                                cells: [
                                  if (Screen.isWeb(context))
                                    Padding(
                                      padding: EdgeInsetsGeometry.fromLTRB(
                                        6,
                                        0,
                                        12,
                                        0,
                                      ),
                                      child: Text(
                                        (index + 1).toString(),
                                        style: CustomColors.getBodyLarge(
                                          context,
                                          null,
                                        ),
                                      ),
                                    ),
                                  CustomTableRowCellText(
                                    flex: 2,
                                    text: test.getNumber(),
                                    textVisibleAlways: true,
                                    subText: test.getName(),
                                    subTextVisibleAlways: true,
                                  ),
                                  CustomTableRowCell(
                                    body: FittedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomStatusDoc(
                                            status: appoint.isStatus(
                                              test.iteration,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          CustomStatusDoc(
                                            status: appoint.isActive(),
                                          ),
                                        ],
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
                                        : (test.iteration -
                                                  appoint.getAttempts())
                                              .toString(),
                                    subTextVisibleAlways: true,
                                  ),
                                  CustomTableRowCellText(
                                    text: appoint.deadline == null
                                        ? 'Без ограничений'
                                        : appoint.deadline!
                                                  .difference(DateTime.now())
                                                  .inDays ==
                                              0
                                        ? 'Сегодня последний день'
                                        : 'Осталось дней ${appoint.deadline!.difference(DateTime.now()).inDays}',
                                    subText: appoint.deadline == null
                                        ? 'Нет'
                                        : DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(appoint.deadline!),
                                    textVisibleAlways: true,
                                    subTextVisibleAlways: true,
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
