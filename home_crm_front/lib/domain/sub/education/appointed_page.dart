import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/appointed_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/store/appointed_store.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
import 'package:home_crm_front/domain/sub/education/widget/appointed_dialog.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme.dart';
import '../../support/components/button/hovered_region.dart';
import '../../support/components/callback/NavBarCallBack.dart';
import '../../support/components/load/custom_load.dart';
import '../../support/components/screen/Screen.dart';
import '../../support/components/skeleton/custom_skeleton.dart';
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

class _AppointedPageState
    extends SheetPageState<AppointedAggregate, AppointedDialog, AppointedPage> {
  bool showDone = false;
  bool showNotActive = false;

  @override
  AppointedDialog show(
    AppointedAggregate selected, {
    bool isSidePanel = false,
  }) {
    return AppointedDialog(
      key: selected.getKey(),
      appointed: selected,
      isSidePanel: isSidePanel,
    );
  }

  @override
  Widget customLabels(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
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
                    : CustomColors.getDisplaySmallButtonIsWeb(context, null),
              ),
            ),
          ],
        ),
        Row(
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
                          style: CustomColors.getTitleMedium(context, null),
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
                          style: CustomColors.getTitleMedium(context, null),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget sliverTable(BuildContext context) {
    return CustomTableLoadSliver(
      key: ValueKey('$showDone-$showNotActive'),
      loader: GetIt.I.get<AppointedStore>().getAll(
        showDone: showDone,
        showNotActive: showNotActive,
      ),
      onLoad: (values) {
        setState(() {
          selected =
              values.firstWhereOrNull((t) => t.id == selected?.id) ??
              values.firstOrNull;
        });
      },
      head: (context, tests) => CustomTableHeadRow(
        cells: [
          if (Screen.isWeb(context))
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
          CustomTableHeadRowCell(text: 'Статус', textVisibleAlways: true),
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
      builder: (context, index, appoint) {
        if (appoint.testId == null) {
          return SizedBox.shrink();
        }
        return CustomLoad.load(
          loader: GetIt.I.get<EducationStore>().get(appoint.testId!),
          skeleton: CustomSkeleton(child: CustomSkeleton.panel(height: 80)),
          builder: (BuildContext context, test) {
            return HoveredRegion(
              key: appoint.getKey(),
              onTap: () async {
                setState(() {
                  selected = appoint;
                  if (!Screen.isSidePanel(context)) {
                    setState(() {
                      GetIt.I.get<SheetElementAddCallback>().call(
                        show(appoint),
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
                        padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
                        child: Text(
                          (index + 1).toString(),
                          style: CustomColors.getBodyLarge(context, null),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomStatusDoc(
                              status: appoint.isStatus(test.iteration),
                            ),
                            const SizedBox(height: 2),
                            CustomStatusDoc(status: appoint.isActive()),
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
                          : (test.iteration - appoint.getAttempts()).toString(),
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
                          : DateFormat('yyyy-MM-dd').format(appoint.deadline!),
                      textVisibleAlways: true,
                      subTextVisibleAlways: true,
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      skeleton: CustomSkeleton(child: CustomSkeleton.panel(height: 80)),
    );
  }
}
