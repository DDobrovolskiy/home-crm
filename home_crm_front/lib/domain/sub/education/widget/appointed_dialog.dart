import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/session_aggregate.dart';
import 'package:home_crm_front/domain/support/components/label/label_page.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/theme.dart';
import '../../../support/components/button/button.dart';
import '../../../support/components/dialog/custom_dialog.dart';
import '../../../support/components/load/custom_load.dart';
import '../../../support/components/screen/Screen.dart';
import '../../../support/components/status/doc.dart';
import '../../../support/components/tab/custom_tab.dart';
import '../aggregate/appointed_aggregate.dart';

class AppointedDialog extends SheetPage {
  @override
  String getName() {
    return appointed.getNumber();
  }

  final AppointedAggregate appointed;

  const AppointedDialog({super.key, required this.appointed});

  @override
  _TestDialogState createState() => _TestDialogState();
}

class _TestDialogState extends State<AppointedDialog> {
  late AppointedAggregate appointed;

  @override
  void initState() {
    super.initState();
    appointed = widget.appointed;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoad.load(appointed.getTest(), (context, test) {
      if (test == null) {
        return SizedBox.shrink();
      }
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0),
                            child: CustomButtonDisplay(
                              primary: true,
                              text: 'Приступить',
                              onPressed: () async {
                                if (validator()) {
                                  // var error = test.doReady();
                                  // if (error != null) {
                                  //   Stamp.showTemporarySnackbar(context, error);
                                  // } else {
                                  //   GetIt.I.get<EducationStore>().save([test]);
                                  //   GetIt.I.get<SheetElementDeleteCallback>().call(
                                  //     widget.getName(),
                                  //   );
                                  //   setState(() {
                                  //
                                  //   });
                                  // }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                              15,
                              0,
                              0,
                              0,
                            ),
                            child: CustomStatusDoc(
                              status: appointed.isStatus(test!.iteration),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: CustomStatusDoc(
                              status: appointed.isActive(),
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
        contents: appointed.sessions.isEmpty
            ? [(key) => CustomTabView(name: 'Инфо', child: empty())]
            : appointed.sessions
            .mapIndexed((index, s) =>
        ((key) =>
            CustomTabView(
                name: '${s.getAbbreviate()}-${index + 1}', child: session(s))),
                  )
                  .toList(),
      );
    });
  }

  Widget empty() {
    return Padding(
      padding: EdgeInsetsDirectional.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.text_snippet_outlined,
            size: 44,
            color: CustomColors.getSecondaryText(context),
          ),
          SizedBox(height: 10),
          Text(
            'Здесь будут результаты тестирования',
            style: CustomColors.getLabelMedium(context, null),
          ),
        ],
      ),
    );
  }

  Widget session(SessionAggregate session) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 2, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
            child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: Screen.getMaxWidth()),
            child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              createLabelRow(
                'Дата начала:',
                DateFormat('yyyy-MM-dd HH:mm').format(session.dateStart),
              ),
              createLabelRow(
                'Дата окончания:',
                DateFormat('yyyy-MM-dd HH:mm').format(session.dateEnd),
              ),
              createLabelRow(
                'Результат тестирования:',
                session.success ? 'Успешный' : 'Неуспешный',
              ),
            ],
            ),),),
        ],
      ),
    );
  }

  Widget createLabelRow(String label, String? value) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: CustomColors.getLabelMedium(context, null)),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: Text(
            value ?? '-',
            textAlign: TextAlign.start,
            style: CustomColors.getHeadLineMedium(context, null),
          ),
        ),
      ],
    );
  }

  // Widget tableAnswers(List<AppointedAggregate> appointed, int iteration) {
  //   return CustomTable(
  //     head: CustomTableHeadRow(
  //       cells: [
  //         IconButton(
  //           onPressed: () async {
  //             setState(() {
  //               appointed.clear();
  //             });
  //           },
  //           color: CustomColors.getSecondaryText(context),
  //           icon: Icon(Icons.delete),
  //         ),
  //         Padding(
  //           padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
  //           child: Text('№', style: CustomColors.getLabelMedium(context, null)),
  //         ),
  //         CustomTableHeadRowCell(
  //           flex: 2,
  //           text: 'Сотрудник',
  //           textVisibleAlways: true,
  //           subText: 'Роль',
  //           subTextVisibleAlways: true,
  //         ),
  //         Flexible(
  //           flex: 2,
  //           child: Padding(
  //             padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 10),
  //             child: Row(
  //               children: [
  //                 CustomButton(
  //                   text: 'Выполнить до',
  //                   onPressed: () {
  //                     CustomCalendar.showSingleDate(
  //                       context,
  //                       null,
  //                       (arg) {
  //                         setState(() {
  //                           appointed.forEach(
  //                             (i) => i.deadline = arg as DateTime?,
  //                           );
  //                         });
  //                         Navigator.pop(context);
  //                       },
  //                       () {
  //                         Navigator.pop(context);
  //                       },
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         CustomTableHeadRowCell(
  //           flex: 1,
  //           text: 'Кол-во попыток',
  //           subText: 'Осталось попыток',
  //           subTextVisibleAlways: true,
  //         ),
  //         CustomTableHeadRowCell(
  //           flex: 1,
  //           text: 'Статус',
  //           textVisibleAlways: true,
  //         ),
  //       ],
  //     ),
  //     rows: [
  //       for (int i = 0; i < appointed.length; i++)
  //         HoveredRegion(
  //           onTap: () async {},
  //           child: (isHovered) {
  //             return CustomTableRow(
  //               hover: isHovered,
  //               cells: [
  //                 IconButton(
  //                   onPressed: () async {
  //                     setState(() {
  //                       appointed.removeAt(i);
  //                     });
  //                   },
  //                   color: CustomColors.getSecondaryText(context),
  //                   icon: Icon(Icons.delete_outline),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsetsGeometry.fromLTRB(6, 0, 12, 0),
  //                   child: Text(
  //                     (i + 1).toString(),
  //                     style: CustomColors.getBodyLarge(context, null),
  //                   ),
  //                 ),
  //                 CustomLoad.load(appointed[i].getEmployee(), (context, emp) {
  //                   return CustomLoad.load(emp!.getRole(), (
  //                     BuildContext context,
  //                     role,
  //                   ) {
  //                     return CustomTableRowCellText(
  //                       flex: 2,
  //                       text: emp.user.name,
  //                       textVisibleAlways: true,
  //                       subText: role?.name,
  //                       subTextVisibleAlways: true,
  //                     );
  //                   });
  //                 }),
  //                 CustomTableRowCell(
  //                   flex: 2,
  //                   textVisibleAlways: true,
  //                   body: Row(
  //                     children: [
  //                       CustomButton(
  //                         text: appointed[i].deadline == null
  //                             ? 'Нет'
  //                             : DateFormat(
  //                                 'yyyy-MM-dd',
  //                               ).format(appointed[i].deadline!),
  //                         onPressed: () {
  //                           CustomCalendar.showSingleDate(
  //                             context,
  //                             appointed[i].deadline,
  //                             (arg) {
  //                               setState(() {
  //                                 appointed[i].deadline = arg as DateTime?;
  //                               });
  //                               Navigator.pop(context);
  //                             },
  //                             () {
  //                               Navigator.pop(context);
  //                             },
  //                           );
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 CustomTableRowCellText(
  //                   flex: 1,
  //                   text: appointed[i].getAttempts().toString(),
  //                   subTextVisibleAlways: true,
  //                   subText: (iteration - appointed[i].getAttempts())
  //                       .toString(),
  //                 ),
  //                 CustomTableRowCell(
  //                   flex: 1,
  //                   textVisibleAlways: true,
  //                   body: Row(
  //                     children: [
  //                       CustomStatusDoc(
  //                         status: appointed[i].isStatus(iteration),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       Padding(
  //         padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
  //         child: Row(
  //           children: [
  //             EmployeeSelect(
  //               saveSelected: false,
  //               text: 'Добавить сотрудника',
  //               excludeId: test.appointed.map((t) => t.employeeId).toSet(),
  //               buttonStyleData: const ButtonStyleData(
  //                 padding: EdgeInsets.symmetric(horizontal: 16),
  //                 height: 60,
  //                 width: 250,
  //               ),
  //               onChanged: (value) {
  //                 print(value);
  //                 setState(() {
  //                   test.appointed.add(
  //                     AppointedAggregate(
  //                         employeeId: value!.id, testId: test.id),
  //                   );
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
