import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/service/employee_service.dart';
import 'package:home_crm_front/domain/sub/employee/widget/employee_dialog.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/organization/state/organization_employee_state.dart';
import 'package:home_crm_front/domain/support/components/table/table.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row_cell.dart';
import 'package:home_crm_front/domain/support/components/table/table_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_row_cell.dart';
import 'package:home_crm_front/theme/theme.dart';

import '../../support/widgets/stamp.dart';
import '../employee/dto/request/employee_delete_dto.dart';
import '../role/widget/role_tooltip.dart';
import '../scope/scope.dart';

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
  var organizationCurrentService = GetIt.instance.get<OrganizationService>();

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
            if (organizationCurrentService.isEditor(
              ScopeType.ORGANIZATION_UPDATE,
            ))
              CustomTableHeadRowCell(text: '', textVisibleAlways: true),
          ],
        ),
        rows: [
          for (final empOrg in state.getBody()!.employees)
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
                CustomTableRowCell(
                  textVisibleAlways: true,
                  body: RoleTooltip(role: empOrg.role),
                ),
                if (organizationCurrentService.isEditor(
                  ScopeType.ORGANIZATION_UPDATE,
                ))
                  CustomTableRowCellPopupMenu(
                    onSelected: (String choice) async {
                      if (choice == 'Edit') {
                        EmployeeDialog.show(context, empOrg);
                      } else if (choice == 'Delete') {
                        await GetIt.I.get<EmployeeService>().deleteEmployee(
                          EmployeeDeleteDto(id: empOrg.id),
                        );
                      }
                    },
                    textVisibleAlways: true,
                    deleteVisible: !empOrg.role.owner,
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
