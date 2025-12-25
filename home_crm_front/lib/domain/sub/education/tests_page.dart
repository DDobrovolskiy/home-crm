import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/skeleton/custom_skeleton.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
  bool showSidePanel = true;
  Set<int> selectIds = {};
  bool showArchive = false;
  int? _idSidePanel;
  TestAggregate? selected;

  TestDialog show(TestAggregate test, {bool isSidePanel = false}) {
    return TestDialog(key: test.getKey(), test: test, isSidePanel: isSidePanel);
  }

  TestDialog create(Map<int, TestAggregate> tests,
      int? id, {
        bool isSidePanel = false,
      }) {
    if (tests.containsKey(id)) {
      return TestDialog(
        key: tests[id]!.getKey(),
        test: tests[id]!,
        isSidePanel: isSidePanel,
      );
    }
    var first = tests.keys.first;
    return TestDialog(
      key: tests[first]!.getKey(),
      test: tests[first]!,
      isSidePanel: isSidePanel,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      cacheExtent: 1500,
      slivers: [
        SliverCrossAxisGroup(
          slivers: [
            SliverCrossAxisExpanded(
              flex: 1,
              sliver: SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                sliver: MultiSliver(
                  children: [_sliverLabel(context), _sliverTable(context)],
                ),
              ),
            ),
            ..._sidePanels(context),
          ],
        ),
      ],
    );
  }

  List<Widget> _sidePanels(BuildContext context) {
    if (selected != null && Screen.isSidePanel(context)) {
      return [
        SliverConstrainedCrossAxis(
          maxExtent: 40,
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: IconButton(
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
              ),
              SliverToBoxAdapter(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      GetIt.I.get<SheetElementAddCallback>().call(
                        show(selected!),
                      );
                    });
                  },
                  icon: Icon(Icons.open_in_browser),
                ),
              ),
            ],
          ),
        ),
        if (showSidePanel)
          SliverConstrainedCrossAxis(
            maxExtent: 700.0,
            sliver: MultiSliver(children: []),
          ),
      ];
    } else {
      return [];
    }
  }

  Widget _sliverLabel(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        color: CustomColors.getPrimaryBackground(context),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 20),
              child: Row(
                children: [
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
                          : CustomColors.getDisplaySmallButtonIsWeb(
                        context,
                        null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: showArchive,
                          activeColor: CustomColors.getPrimary(context),
                          onChanged: (bool? value) async {
                            if (value != null) {
                              setState(() {
                                showArchive = value;
                              });
                            }
                          },
                        ),
                        Text(
                          'Показать архивные',
                          style: CustomColors.getTitleMedium(context, null),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: selectIds.isEmpty
                      ? null
                      : () {
                    GetIt.I.get<EducationStore>().toArchive(selectIds);
                    setState(() {
                      selectIds.clear();
                    });
                  },
                  tooltip: 'Отправить в архив',
                  icon: Icon(Icons.archive),
                ),
                IconButton(
                  onPressed: selectIds.isEmpty
                      ? null
                      : () {
                    GetIt.I.get<EducationStore>().delete(selectIds);
                    setState(() {
                      selectIds.clear();
                    });
                  },
                  tooltip: 'Удалить полностью',
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliverTable(BuildContext context) {
    return CustomTableSliver(
      key: ValueKey(showArchive),
      loader: GetIt.I.get<EducationStore>().getAll(showArchive),
      onLoad: (tests) {
        setState(() {
          selected =
              tests.firstWhereOrNull((t) => t.id == selected?.id) ??
                  tests.firstOrNull;
        });
      },
      head: (context, tests) =>
          CustomTableHeadRow(
            cells: [
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
                child: Checkbox(
                  value: selectIds.length == tests.length &&
                      selectIds.isNotEmpty,
                  activeColor: CustomColors.getPrimary(context),
                  onChanged: (bool? value) async {
                    if (value != null) {
                      if (value) {
                        setState(() {
                          selectIds = tests
                              .map((e) => e.id)
                              .nonNulls
                              .toSet();
                        });
                      } else {
                        setState(() {
                          selectIds.clear();
                        });
                      }
                    }
                  },
                ),
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
              ),
            ],
          ),
      builder: (context, index, test) {
        return HoveredRegion(
          key: test.getKey(),
          onTap: () async {
            setState(() {
              selected = test;
              if (!Screen.isSidePanel(context)) {
                setState(() {
                  GetIt.I.get<SheetElementAddCallback>().call(show(test));
                });
              }
            });
          },
          child: (isHovered) {
            return CustomTableRow(
              hover: isHovered,
              cells: [
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
                  child: Checkbox(
                    value: selectIds.contains(test.id),
                    activeColor: CustomColors.getPrimary(context),
                    onChanged: (bool? value) async {
                      if (value != null) {
                        if (value) {
                          setState(() {
                            selectIds.add(test.id!);
                          });
                        } else {
                          setState(() {
                            selectIds.remove(test.id);
                          });
                        }
                      }
                    },
                  ),
                ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final appoint in test.appointed)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.all(5),
                              child: CustomLoad.load(
                                appoint.getEmployee(),
                                    (context, emp) {
                                  return Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${emp?.user.name}',
                                        style: CustomColors.getBodyLarge(
                                          context,
                                          null,
                                        ),
                                      ),
                                      CustomLoad.load(
                                        emp!.getRole(),
                                            (BuildContext context, role) {
                                          return Padding(
                                            padding:
                                            EdgeInsetsDirectional.symmetric(
                                              vertical: 0,
                                            ),
                                            child: Text(
                                              '${role?.name}',
                                              style:
                                              CustomColors.getLabelSmall(
                                                context,
                                                null,
                                              ),
                                            ),
                                          );
                                        },
                                        skeleton: CustomSkeleton(
                                          child: CustomSkeleton.panel(
                                            width: 80,
                                            height: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                skeleton: CustomSkeleton(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomSkeleton.panel(
                                        width: 100,
                                        height: 16,
                                      ),
                                      CustomSkeleton.panel(
                                        width: 80,
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (Screen.isWeb(context))
                              Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 2,
                                ),
                                child: CustomStatusDoc(
                                  status: appoint.isStatus(test.iteration),
                                ),
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
      },
      skeleton: CustomSkeleton(
        child: CustomSkeleton.panel(height: 80),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return CustomLoad.load(GetIt.I.get<EducationStore>().getAllMap(), (
      BuildContext context,
      tests,
    ) {
      return Row(
        children: [
          Expanded(child: _table(context, tests)),
          if (tests.isNotEmpty && Screen.isSidePanel(context))
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
                          create(tests, _idSidePanel),
                        );
                      });
                    },
                    icon: Icon(Icons.open_in_browser),
                  ),
                ],
              ),
            ),
          if (showSidePanel && tests.isNotEmpty && Screen.isSidePanel(context))
            SizedBox(
              width: 700,
              child: create(tests, _idSidePanel, isSidePanel: true),
            ),
        ],
      );
    });
  }

  Widget _table(BuildContext context, Map<int, TestAggregate> tests) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight < 150) {
          return SizedBox.shrink();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        : CustomColors.getDisplaySmallButtonIsWeb(
                      context,
                      null,
                    ),
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
                    child: Row(
                      children: [
                        Checkbox(
                          value: showArchive,
                          activeColor: CustomColors.getPrimary(context),
                          onChanged: (bool? value) async {
                            if (value != null) {
                              setState(() {
                                showArchive = value;
                              });
                            }
                          },
                        ),
                        Text(
                          'Показать архивные',
                          style: CustomColors.getTitleMedium(context, null),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: selectIds.isEmpty
                      ? null
                      : () {
                    var list = selectIds
                        .map((i) {
                      var t = tests[i];
                      t?.doArchive();
                      return t;
                    })
                        .nonNulls
                        .toList();
                    GetIt.I.get<EducationStore>().save(list);
                    setState(() {
                      if (selectIds.contains(_idSidePanel)) {
                        _idSidePanel = null;
                      }
                      selectIds.clear();
                    });
                  },
                  tooltip: 'Отправить в архив',
                  icon: Icon(Icons.archive),
                ),
                IconButton(
                  onPressed: selectIds.isEmpty
                      ? null
                      : () {
                    GetIt.I.get<EducationStore>().delete(selectIds);
                    setState(() {
                      if (selectIds.contains(_idSidePanel)) {
                        _idSidePanel = null;
                      }
                      selectIds.clear();
                    });
                  },
                  tooltip: 'Удалить полностью',
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            Flexible(child: _tableTests(tests)),
          ],
        );
      },
    );
  }

  Widget _tableTests(Map<int, TestAggregate> tests) {
    return CustomTable(
      head: CustomTableHeadRow(
        cells: [
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
            child: Checkbox(
              value: selectIds.length == tests.length && selectIds.isNotEmpty,
              activeColor: CustomColors.getPrimary(context),
              onChanged: (bool? value) async {
                if (value != null) {
                  if (value) {
                    setState(() {
                      selectIds.addAll(tests.keys);
                    });
                  } else {
                    setState(() {
                      selectIds.clear();
                    });
                  }
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
            child: Text('№', style: CustomColors.getLabelMedium(context, null)),
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
            subText: 'Кол-во попыток',
            subTextVisibleAlways: true,
          ),
          CustomTableHeadRowCell(
            flex: 2,
            text: 'Назначен',
            textVisibleAlways: true,
          ),
        ],
      ),
      rows: [
        ...tests.values
            .where((t) => t.active == true || showArchive)
            .mapIndexed((index,
            test,) {
          return HoveredRegion(
            key: test.getKey(),
            onTap: () async {
              CheckScope(
                onTrue: () {
                  setState(() {
                    _idSidePanel = test.id!;
                    if (!Screen.isSidePanel(context)) {
                      setState(() {
                        GetIt.I.get<SheetElementAddCallback>().call(
                          create(tests, _idSidePanel),
                        );
                      });
                    }
                  });
                },
              ).checkScope(ScopeType.TEST_CREATE, context);
            },
            child: (isHovered) {
              return CustomTableRow(
                hover: isHovered,
                cells: [
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
                    child: Checkbox(
                      value: selectIds.contains(test.id),
                      activeColor: CustomColors.getPrimary(context),
                      onChanged: (bool? value) async {
                        if (value != null) {
                          if (value) {
                            setState(() {
                              selectIds.add(test.id!);
                            });
                          } else {
                            setState(() {
                              selectIds.remove(test.id);
                            });
                          }
                        }
                      },
                    ),
                  ),
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
                    body: AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final appoint in test.appointed)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsGeometry.all(5),
                                  child: CustomLoad.load(
                                    appoint.getEmployee(),
                                        (context, emp) {
                                      return Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${emp?.user.name}',
                                            style: CustomColors.getBodyLarge(
                                              context,
                                              null,
                                            ),
                                          ),
                                          CustomLoad.load(
                                            emp!.getRole(),
                                                (BuildContext context, role) {
                                              return Padding(
                                                padding:
                                                EdgeInsetsDirectional.symmetric(
                                                  vertical: 0,
                                                ),
                                                child: Text(
                                                  '${role?.name}',
                                                  style:
                                                  CustomColors.getLabelSmall(
                                                    context,
                                                    null,
                                                  ),
                                                ),
                                              );
                                            },
                                            skeleton: CustomSkeleton(
                                              child: CustomSkeleton.panel(
                                                width: 80,
                                                height: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    skeleton: CustomSkeleton(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomSkeleton.panel(
                                            width: 100,
                                            height: 16,
                                          ),
                                          CustomSkeleton.panel(
                                            width: 80,
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (Screen.isWeb(context))
                                  Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 2,
                                    ),
                                    child: CustomStatusDoc(
                                      status: appoint.isStatus(test.iteration),
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
          );
        }),
      ],
    );
  }
}
