import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/role/widget/role_add.dart';
import 'package:home_crm_front/domain/sub/scope/scope.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';

import '../../../theme/theme.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';

class OrganizationRolesWrapper extends StatelessWidget {
  const OrganizationRolesWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return OrganizationRolesPage();
  }
}

@RoutePage()
class OrganizationRolesPage extends StatefulWidget {
  const OrganizationRolesPage({super.key});

  @override
  _OrganizationRolesPageState createState() => _OrganizationRolesPageState();
}

class _OrganizationRolesPageState extends State<OrganizationRolesPage> {
  var organizationCurrentService = GetIt.instance
      .get<OrganizationCurrentService>();

  @override
  void initState() {
    organizationCurrentService.refreshOrganizationRoles(Loaded.ifNotLoad);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return organizationCurrentService.organizationRole(context, (
      context,
        organization,) {
      return CustomTable(
        head: CustomTableHeadRow(
          cells: [
            CustomTableHeadRowCell(
              text: 'Название',
              textVisibleAlways: true,
              subText: 'Описание',
            ),
            CustomTableHeadRowCell(text: 'Описание', flex: 2),
            CustomTableHeadRowCell(text: 'Сотрудники с ролью'),
            CustomTableHeadRowCell(
              flex: 2,
              text: 'Разрешения',
              textVisibleAlways: true,
              subText: 'Описание',
              subTextVisibleAlways: true,
            ),
            CustomTableHeadRowCell(text: '', textVisibleAlways: true),
          ],
        ),
        rows: [
          for (final role in organization.roles)
            CustomTableRow(
              cells: [
                CustomTableRowCellText(
                  text: role.role.name,
                  textVisibleAlways: true,
                  subText: role.role.description,
                ),
                CustomTableRowCellText(text: role.role.description, flex: 2),
                CustomTableRowCell(
                  body: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final employee in role.roleEmployee.employees)
                        Text(
                          employee.user.name,
                          style: CustomColors.getBodyLarge(context, null),
                        ),
                    ],
                  ),
                ),
                CustomTableRowCell(
                  flex: 2,
                  textVisibleAlways: true,
                  body: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (role.role.owner)
                        Text(
                          '[Нет ограничений]',
                          style: CustomColors.getBodyLarge(context, null),
                        ),
                      for (final scope in role.roleScopes.scopes)
                        Row(
                          children: [
                            Text(
                              scope.description,
                              style: CustomColors.getBodyLarge(context, null),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                if (organizationCurrentService.isEditor(
                    ScopeType.ORGANIZATION_UPDATE))
                  CustomTableRowCell(
                    textVisibleAlways: true,
                    body: PopupMenuButton<String>(
                      color: CustomColors.getSecondaryBackground(context),
                      icon: Icon(Icons.more_horiz), // Три точки
                      onSelected: (String choice) {
                        if (choice == 'Edit') {
                          // OrganizationDialog(
                          //   organization: organization,
                          // ).addOrganization(context);
                        } else if (choice == 'Delete') {
                          // BlocProvider.of<OrganizationEditBloc>(
                          //   context,
                          // ).add(
                          //   OrganizationEditDeleteEvent(
                          //     id: organization.id,
                          //   ),
                          // );
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Edit',
                            child: Text(
                              'Редактировать',
                              style: CustomColors.getBodyMedium(context, null),
                            ),
                          ),
                          if (!role.role.owner)
                            PopupMenuItem<String>(
                              value: 'Delete',
                              child: Text(
                                'Удалить',
                                style: CustomColors.getBodyMedium(
                                  context,
                                  null,
                                ),
                              ),
                            ),
                        ];
                      },
                    ),
                  ),
              ],
            ),
          if (organizationCurrentService.isEditor(
              ScopeType.ORGANIZATION_UPDATE))
            CustomTableRow(cells: [
              IconButton(onPressed: () async {
                RoleAdd().build(context);
              }, icon: Icon(Icons.add_circle))
            ]),
        ],
      );
    });
  }

  // Widget getContent(BuildContext context, OrganizationRoleState state) {
  //   if (!state.loaded) {
  //     return Stamp.loadWidget(context);
  //   } else if (state.organization != null) {
  //     return Column(
  //       children: [
  //         for (final role in state.organization!.roles)
  //           Card(
  //             margin: const EdgeInsets.all(8),
  //             child: ListTile(
  //               leading: Icon(Icons.account_box),
  //               title: Text(role.role.name),
  //               subtitle: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Text('Описание: ${role.role.description}'),
  //                       ?delete(context, role, state),
  //                     ],
  //                   ),
  //                   Text('Сотрудники с ролью:', textAlign: TextAlign.left),
  //                   Column(
  //                     children: [
  //                       for (final employee in role.roleEmployee.employees)
  //                         Stamp.giperLinkText(
  //                           Text(employee.user.name, textAlign: TextAlign.left),
  //                           () {
  //                             AutoRouter.of(
  //                               context,
  //                             ).push(EmployeeRoute(employeeId: employee.id));
  //                           },
  //                         ),
  //                     ],
  //                   ),
  //                   Text('Права роли:', textAlign: TextAlign.left),
  //                   Column(
  //                     children: [
  //                       for (final scope in role.roleScopes.scopes)
  //                         Text(scope.description, textAlign: TextAlign.left),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               trailing: edit(context, role, state),
  //             ),
  //           ),
  //         // Кнопка добавления новой организации-владельца
  //         if (state.hasEdit)
  //           Card(
  //             color: Colors.blue.shade100,
  //             margin: const EdgeInsets.all(8),
  //             child: ListTile(
  //               leading: Icon(Icons.add_circle_outline),
  //               title: Text("Добавить роль"),
  //               onTap: () {
  //                 AutoRouter.of(context).push(RoleRoute(roleId: null));
  //               },
  //             ),
  //           ),
  //       ],
  //     );
  //   } else {
  //     return Stamp.errorWidget(context);
  //   }
  // }

  // Widget? edit(
  //   BuildContext context,
  //   RoleFullDto role,
  //   OrganizationRoleState state,
  // ) {
  //   if (state.hasEdit) {
  //     return OutlinedButton.icon(
  //       // Добавили кнопку с иконкой
  //       icon: Icon(Icons.edit),
  //       label: Text("Редактировать"),
  //       onPressed: () {
  //         AutoRouter.of(context).push(RoleRoute(roleId: role.role.id));
  //       },
  //     );
  //   } else {
  //     return null;
  //   }
  // }

  // Widget? delete(
  //   BuildContext context,
  //   RoleFullDto role,
  //   OrganizationRoleState state,
  // ) {
  //   if (state.hasEdit) {
  //     return IconButton(
  //       icon: Icon(Icons.close),
  //       onPressed: () {
  //         BlocProvider.of<RoleEditBloc>(
  //           context,
  //         ).add(RoleEditDeleteEvent(id: role.role.id));
  //       },
  //     );
  //   } else {
  //     return null;
  //   }
  // }
}
