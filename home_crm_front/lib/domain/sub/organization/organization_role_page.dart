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
import '../../support/components/button/hovered_region.dart';
import '../../support/components/scope/check_scope.dart';
import '../../support/components/sheetbar/sheet_bar_page.dart';
import '../../support/components/table/table.dart';
import '../../support/components/table/table_head_row.dart';
import '../../support/components/table/table_head_row_cell.dart';
import '../../support/components/table/table_row.dart';
import '../../support/components/table/table_row_cell.dart';
import '../employee/widget/employee_tooltip.dart';
import '../role/widget/role_dialog.dart';
import '../role/widget/role_scope.dart';
import 'bloc/organization_role_bloc.dart';

@RoutePage()
class OrganizationRolesPage extends SheetPage {
  static String name = 'Роли';
  const OrganizationRolesPage({super.key});

  @override
  String getName() {
    return name;
  }

  @override
  _OrganizationRolesPageState createState() => _OrganizationRolesPageState();
}

class _OrganizationRolesPageState extends State<OrganizationRolesPage>
    with AutomaticKeepAliveClientMixin<OrganizationRolesPage> {
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    organizationCurrentService.refreshOrganizationRoles(Loaded.ifNotLoad);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      flex: 1,
                      text: 'Разрешения',
                      textVisibleAlways: true,
                      subText: 'Описание',
                      subTextVisibleAlways: true,
                    ),
                  ],
                ),
                rows: [
                  for (final role in state.getBody()!.roles)
                    HoveredRegion(
                      onTap: () async {
                        CheckScope(
                          onTrue: () {
                            RoleDialog.show(context, role.role);
                          },
                        ).checkScope(ScopeType.ORGANIZATION_UPDATE, context);
                      },
                      child: (isHovered) {
                        return CustomTableRow(
                          hover: isHovered,
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
                                    EmployeeTooltip(employee: employee),
                                ],
                              ),
                            ),
                            CustomTableRowCell(
                              flex: 1,
                              textVisibleAlways: true,
                              body: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RoleScopes(
                                    role: role.role,
                                    style: CustomColors.getBodyLarge(
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
