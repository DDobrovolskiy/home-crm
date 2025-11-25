import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/bloc/employee_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/event/employee_edit_event.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_state.dart';
import 'package:home_crm_front/domain/support/components/navbar/NavElementList.dart';
import 'package:home_crm_front/domain/support/components/screen/Screen.dart';
import 'package:home_crm_front/domain/support/router/roters.gr.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/widgets/stamp.dart';
import '../employee/dto/response/employee_dto.dart';

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
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: CustomColors.getPrimaryBackground(context),
            appBar: !Screen.isWeb(context) ? getAppBar(context) : null,
            body: getContentBody(context),
          ),
        );
      },
    );
  }

  PreferredSizeWidget getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.getPrimary(context),
      automaticallyImplyLeading: false,
      title: Text(
        'Dashboard',
        style: CustomColors.getDisplaySmall(
          context,
          CustomColors.getPrimaryBtnText(context),
        ),
      ),
    );
    //+add animation
  }

  Widget getContentBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Screen.isWeb(context)) getNavBar(context),
              Expanded(flex: 10, child: getTable(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget getNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
      child: Container(
        width: 270,
        height: double.infinity,
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: CustomColors.getSecondaryBackground(context),
          boxShadow: [
            BoxShadow(
              color: CustomColors.getAlternate(context),
              offset: Offset(1, 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //LOGO
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      Theme
                          .of(context)
                          .brightness == Brightness.dark
                          ? 'assets/common/logo.png'
                          : 'assets/common/logo.png',
                      width: 44,
                      height: 44,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),
              //SEARCH
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColors.getPrimaryBackground(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: CustomColors.getSecondaryText(context),
                          size: 28,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Search',
                            style: CustomColors.getLabelLarge(context, null),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //ELEMENTS
              NavElementList()
                  .add(Item(
                  label: 'Dashboard', icon: Icons.dashboard_rounded, onTap: () {
                print('Dashboard');
              }))
                  .add(Item(
                  label: 'Customers', icon: Icons.business_rounded, onTap: () {
                print('Customers');
              })),
              //MY PROFILE
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    0,
                    0,
                    0,
                    16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        height: 12,
                        thickness: 2,
                        color: CustomColors.getAlternate(context),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          0,
                          12,
                          0,
                          0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: CustomColors.getAccent1(
                                  context,
                                ),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                border: Border.all(
                                  color: CustomColors.getPrimary(
                                    context,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  child: Icon(Icons.face, size: 44),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                  12,
                                  0,
                                  0,
                                  0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Andrew D.',
                                      style:
                                      CustomColors.getBodyLarge(
                                        context,
                                        null,
                                      ),
                                    ),
                                    Text(
                                      'admin@gmail.com',
                                      style:
                                      CustomColors.getLabelMedium(
                                        context,
                                        null,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        4,
                                        0,
                                        0,
                                      ),
                                      child: Text(
                                        'View Profile',
                                        style:
                                        CustomColors.getBodySmall(
                                          context,
                                          CustomColors.getPrimary(
                                            context,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavElementWithHover(BuildContext context, {
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onHover: (hovering) {
            // Здесь можно запустить анимацию или какое-то другое действие при наведении
            print('object');
          },
          onTap: () {}, // Сюда можно поставить действие при тапе
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: foregroundColor, size: 28),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      label,
                      style: CustomColors.getBodyLarge(context, null),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getContent(BuildContext context, OrganizationEmployeeState state) {
    if (!state.loaded) {
      return Stamp.loadWidget(context);
    } else if (state.organization != null) {
      if (true) {
        return getTable(context);
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

  Widget? edit(BuildContext context,
      EmployeeDto empOrg,
      OrganizationEmployeeState state,) {
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

  Widget? delete(BuildContext context,
      EmployeeDto empOrg,
      OrganizationEmployeeState state,) {
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

  Widget getTable(BuildContext context) {
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .displaySmall,
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
              width: MediaQuery
                  .sizeOf(context)
                  .width,
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                          if (flag)
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Email',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium,
                              ),
                            ),
                          if (flag)
                            Expanded(
                              child: Text(
                                'Last Active',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium,
                              ),
                            ),
                          if (flag)
                            Expanded(
                              child: Text(
                                'Date Created',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              'Status',
                              textAlign: TextAlign.end,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
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
                                                Text('Alex Smith',
                                                    style: CustomColors
                                                        .getBodyLarge(
                                                        context, null)),
                                                if (!flag)
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                      0,
                                                      2,
                                                      0,
                                                      0,
                                                    ),
                                                    child: Text(
                                                        'user@domainname.com',
                                                        style: CustomColors
                                                            .getLabelMedium(
                                                            context, null)
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
                                          style: Theme
                                              .of(
                                            context,
                                          )
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    if (flag)
                                      Expanded(
                                        child: Text(
                                          '12-07-1990',
                                          style: Theme
                                              .of(
                                            context,
                                          )
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    if (flag)
                                      Expanded(
                                        child: Text(
                                          '12-07-1990',
                                          style: Theme
                                              .of(
                                            context,
                                          )
                                              .textTheme
                                              .bodyMedium,
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
                                            style: Theme
                                                .of(
                                              context,
                                            )
                                                .textTheme
                                                .bodyMedium,
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
                                                style: Theme
                                                    .of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .labelSmall,
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
