import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/bloc/employee_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/event/employee_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_state.dart';
import 'package:home_crm_front/domain/support/components/screen/Screen.dart';
import 'package:home_crm_front/domain/support/components/table/table.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row_cell.dart';
import 'package:home_crm_front/domain/support/components/table/table_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_row_cell.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/widgets/stamp.dart';
import '../employee/dto/response/employee_dto.dart';

class OrganizationEmployeesWrapper extends StatelessWidget {
  const OrganizationEmployeesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return OrganizationEmployeesPage();
  }
}

@RoutePage()
class OrganizationEmployeesPage extends StatefulWidget {
  const OrganizationEmployeesPage({super.key});

  @override
  _OrganizationEmployeesPageState createState() =>
      _OrganizationEmployeesPageState();
}

class _OrganizationEmployeesPageState extends State<OrganizationEmployeesPage> {
  @override
  void initState() {
    BlocProvider.of<OrganizationEmployeeBloc>(
      context,
    ).add(OrganizationEmployeeRefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationEmployeeBloc, OrganizationEmployeeState>(
      listener: (context, state) {
        if (state is OrganizationEmployeeErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        return getContent(context, state);
      },
    );
  }

  Widget getContent(BuildContext context, OrganizationEmployeeState state) {
    if (!state.loaded) {
      return Stamp.loadWidget(context);
    } else if (state.organization != null) {
      if (true) {
        return CustomTable(
          head: CustomTableHeadRow(
            cells: [
              CustomTableHeadRowCell(
                text: 'ФИО',
                flex: 2,
                textVisibleAlways: true,
                subText: 'Телефон',
              ),
              CustomTableHeadRowCell(text: 'Телефон', flex: 2),
              CustomTableHeadRowCell(
                text: 'Должность',
                textVisibleAlways: true,
              ),
            ],
          ),
          rows: [
            for (final empOrg in state.organization!.employees)
              CustomTableRow(
                cells: [
                  CustomTableRowCellText(
                    text: empOrg.user.name,
                    flex: 2,
                    textVisibleAlways: true,
                    subText: empOrg.user.phone,
                    icon: Icon(Icons.face),
                  ),
                  CustomTableRowCellText(text: empOrg.user.phone, flex: 2),
                  CustomTableRowCellText(
                    text: empOrg.role.name,
                    textVisibleAlways: true,
                  ),
                ],
              ),
            CustomTableRow(
              cells: [
                CustomTableRowCellText(
                  text: '',
                  textVisibleAlways: true,
                  icon: IconButton(
                    onPressed: () async {},
                    icon: Icon(Icons.add_circle),
                  ),
                ),
              ],
            ),
          ],
        );
        return getTable(context, state);
      } else {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
          child: Column(
            children: [
              for (final empOrg in state.organization!.employees)
                Card(
                  margin: const EdgeInsets.all(4),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: Icon(Icons.face, size: 45),
                        ),
                        Expanded(
                          child: Container(
                            width: 356.4,
                            height: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 36.3,
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Hello World Hello World Hello World Hello World Hello World Hello World Hello World',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Hello World Hello World Hello World Hello World Hello World Hello World Hello World',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          constraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 50,
                            maxWidth: 50,
                            maxHeight: 150,
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: IconButton(
                            icon: Icon(Icons.delete, size: 24),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // child: ListTile(
                  //   leading: Icon(Icons.face),
                  //   title: Text(empOrg.user.name),
                  //   subtitle: Wrap(
                  //     spacing: 8,
                  //     children: [
                  //       Text('Роль: '),
                  //       TextButton(
                  //         style: Stamp.giperLink(),
                  //         child: Text('${empOrg.role.name}'),
                  //         onPressed: () {
                  //           AutoRouter.of(
                  //             context,
                  //           ).push(RoleRoute(roleId: empOrg.role.id));
                  //         },
                  //       ),
                  //       Text('Описание: ${empOrg.role.description}'),
                  //       ?delete(context, empOrg, state),
                  //     ],
                  //   ),
                  //   trailing: edit(context, empOrg, state),
                  // ),
                ),
              if (state.hasEdit)
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // выравниваем по центру вертикально и слева
                    child: IconButton(
                      icon: Icon(Icons.add),
                      // child: Text('Добавить сотрудника'),
                      onPressed: () {
                        AutoRouter.of(
                          context,
                        ).push(EmployeeRoute(employeeId: null));
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      }
    } else {
      return Stamp.errorWidget(context);
    }
  }

  Widget? edit(
    BuildContext context,
    EmployeeDto empOrg,
    OrganizationEmployeeState state,
  ) {
    if (state.hasEdit) {
      return OutlinedButton.icon(
        // Добавили кнопку с иконкой
        icon: Icon(Icons.edit),
        label: Text("Редактировать"),
        onPressed: () {
          AutoRouter.of(context).push(EmployeeRoute(employeeId: empOrg.id));
        },
      );
    } else {
      return null;
    }
  }

  Widget? delete(
    BuildContext context,
    EmployeeDto empOrg,
    OrganizationEmployeeState state,
  ) {
    if (state.hasEdit) {
      return IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          BlocProvider.of<EmployeeEditBloc>(
            context,
          ).add(EmployeeEditDeleteEvent(id: empOrg.id));
        },
      );
    } else {
      return null;
    }
  }

  Widget getTable(BuildContext context, OrganizationEmployeeState state) {
    bool flag = Screen.isWeb(context);
    return SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (flag)
            Container(
              width: double.infinity,
              height: 34,
              decoration: BoxDecoration(
                color: CustomColors.getPrimaryBackground(context),
              ),
            ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 1, 0, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColors.getPrimaryBackground(context),
              ),
              alignment: AlignmentDirectional(-1, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
                      child: Text(
                        'My Team',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 24, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: CustomColors.getPrimaryBackground(context),
                        size: 30,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 44),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: CustomColors.getSecondaryBackground(context),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x1F000000),
                    offset: Offset(0.0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: CustomColors.getPrimaryBackground(context),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Member Name',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          if (flag)
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Email',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          if (flag)
                            Expanded(
                              child: Text(
                                'Last Active',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          if (flag)
                            Expanded(
                              child: Text(
                                'Date Created',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              'Status',
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: CustomColors.getSecondaryBackground(
                                  context,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 0,
                                    color: CustomColors.getLineColor(context),
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  0,
                                                  12,
                                                  0,
                                                ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Icon(Icons.account_box),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Alex Smith',
                                                  style:
                                                      CustomColors.getBodyLarge(
                                                        context,
                                                        null,
                                                      ),
                                                ),
                                                if (!flag)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional.fromSTEB(
                                                          0,
                                                          2,
                                                          0,
                                                          0,
                                                        ),
                                                    child: Text(
                                                      'user@domainname.com',
                                                      style:
                                                          CustomColors.getLabelMedium(
                                                            context,
                                                            null,
                                                          ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (flag)
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'user@domain.com',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    if (flag)
                                      Expanded(
                                        child: Text(
                                          '12-07-1990',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    if (flag)
                                      Expanded(
                                        child: Text(
                                          '12-07-1990',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Contacted',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                          if (!flag)
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    0,
                                                    2,
                                                    0,
                                                    0,
                                                  ),
                                              child: Text(
                                                '12-07-1990',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.labelSmall,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
