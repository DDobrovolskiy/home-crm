import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/widget/employee_dialog.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_state.dart';
import 'package:home_crm_front/domain/support/components/sheetbar/sheet_bar_page.dart';
import 'package:home_crm_front/domain/support/components/table/table.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row_cell.dart';
import 'package:home_crm_front/domain/support/components/table/table_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_row_cell.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/components/button/hovered_region.dart';
import '../../support/components/scope/check_scope.dart';
import '../../support/service/loaded.dart';
import '../../support/widgets/stamp.dart';
import '../role/widget/role_tooltip.dart';
import '../scope/scope.dart';

@RoutePage()
class OrganizationEmployeesPage extends SheetPage {
  static String name = 'Сотрудники';
  const OrganizationEmployeesPage({super.key});

  @override
  String getName() {
    return name;
  }

  @override
  _OrganizationEmployeesPageState createState() =>
      _OrganizationEmployeesPageState();
}

class _OrganizationEmployeesPageState extends State<OrganizationEmployeesPage>
    with AutomaticKeepAliveClientMixin<OrganizationEmployeesPage> {
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    organizationCurrentService.refreshOrganizationEmployees(Loaded.ifNotLoad);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    if (!state.loaded()) {
      return Stamp.loadWidget(context);
    } else if (state.getBody() != null) {
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
            CustomTableHeadRowCell(text: 'Должность', textVisibleAlways: true),
          ],
        ),
        rows: [
          for (final empOrg in state.getBody()!.employees)
            HoveredRegion(
              onTap: () async {
                CheckScope(
                  onTrue: () {
                    if (!empOrg.role.owner) {
                      EmployeeDialog.show(context, empOrg);
                    } else {
                      Stamp.showTemporarySnackbar(
                        context,
                        'Редактирование ${empOrg.user.name} запрещено',
                      );
                    }
                  },
                ).checkScope(ScopeType.ORGANIZATION_UPDATE, context);
              },
              child: (isHovered) {
                return CustomTableRow(
                  hover: isHovered,
                  cells: [
                    CustomTableRowCellText(
                      text: empOrg.user.name,
                      flex: 2,
                      textVisibleAlways: true,
                      subText: empOrg.user.phone,
                      icon: Icon(Icons.face),
                    ),
                    CustomTableRowCellText(text: empOrg.user.phone, flex: 2),
                    CustomTableRowCell(
                      textVisibleAlways: true,
                      body: RoleTooltip(role: empOrg.role),
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
                      EmployeeDialog.show(context, null);
                    },
                    color: CustomColors.getSecondaryText(context),
                    icon: Icon(Icons.add_circle),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      return Stamp.errorWidget(context);
    }
  }
}
