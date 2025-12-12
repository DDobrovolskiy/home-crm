import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_role_state.dart';
import 'package:home_crm_front/domain/sub/scope/scope.dart';
import 'package:home_crm_front/domain/support/service/loaded.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../../../theme/theme.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';
import '../role/dto/request/role_delete_dto.dart';
import '../role/service/role_service.dart';
import '../role/widget/role_dialog.dart';
import '../user/widget/user_tooltip.dart';
import 'bloc/organization_role_bloc.dart';

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
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();

  @override
  void initState() {
    organizationCurrentService.refreshOrganizationRoles(Loaded.ifNotLoad);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrganizationRoleBloc, OrganizationRoleState>(
      listener: (context, state) {
        if (state is OrganizationRoleErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (!state.loaded()) {
          return Stamp.loadWidget(context);
        } else if (state.getBody() != null) {
          return Column(
            children: [
              CustomTable(
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
                    if (organizationCurrentService.isEditor(
                      ScopeType.ORGANIZATION_UPDATE,
                    ))
                      CustomTableHeadRowCell(text: '', textVisibleAlways: true),
                  ],
                ),
                rows: [
                  for (final role in state.getBody()!.roles)
                    CustomTableRow(
                      cells: [
                        CustomTableRowCellText(
                          text: role.role.name,
                          textVisibleAlways: true,
                          subText: role.role.description,
                        ),
                        CustomTableRowCellText(
                          text: role.role.description,
                          flex: 2,
                        ),
                        CustomTableRowCell(
                          body: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final employee
                                  in role.roleEmployee.employees)
                                UserTooltip(user: employee.user),
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
                              if (role.roleScopes.scopes.isEmpty &&
                                  !role.role.owner)
                                Text(
                                  '[Отсутствуют]',
                                  style: CustomColors.getBodyLarge(
                                    context,
                                    null,
                                  ),
                                ),
                              if (role.role.owner)
                                Text(
                                  '[Нет ограничений]',
                                  style: CustomColors.getBodyLarge(
                                    context,
                                    null,
                                  ),
                                ),
                              for (final scope in role.roleScopes.scopes)
                                Row(
                                  children: [
                                    Text(
                                      scope.description,
                                      style: CustomColors.getBodyLarge(
                                        context,
                                        null,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (organizationCurrentService.isEditor(
                          ScopeType.ORGANIZATION_UPDATE,
                        ))
                          CustomTableRowCellPopupMenu(
                            onSelected: (String choice) async {
                              if (choice == 'Edit') {
                                RoleDialog.show(context, role.role);
                              } else if (choice == 'Delete') {
                                if (role.roleEmployee.employees.isNotEmpty) {
                                  Stamp.showTemporarySnackbar(
                                    context,
                                    'Чтобы удалить роль, необходимо сначала сотрудников с ролью распределить на другие роли',
                                  );
                                } else {
                                  await GetIt.I.get<RoleService>().deleteRole(
                                    RoleDeleteDto(id: role.role.id),
                                  );
                                }
                              }
                            },
                            textVisibleAlways: true,
                            deleteVisible: !role.role.owner,
                          ),
                      ],
                    ),
                  if (organizationCurrentService.isEditor(
                    ScopeType.ORGANIZATION_UPDATE,
                  ))
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              RoleDialog.show(context, null);
                            },
                            color: CustomColors.getSecondaryText(context),
                            icon: Icon(Icons.add_circle),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          );
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }
}
