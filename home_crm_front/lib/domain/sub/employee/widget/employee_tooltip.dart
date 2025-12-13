import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/widget/employee_dialog.dart';
import 'package:home_crm_front/domain/sub/role/widget/role_tooltip.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/tooltip/custom_tooltip_host.dart';
import '../../organization/service/organization_service.dart';
import '../../scope/scope.dart';
import '../dto/response/employee_dto.dart';

class EmployeeTooltip extends StatelessWidget {
  final EmployeeDto employee;
  final TextStyle? style;

  const EmployeeTooltip({super.key, required this.employee, this.style});

  @override
  Widget build(BuildContext context) {
    return CustomTooltipHost(
      tooltipContent: (hide) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${employee.user.id}',
                  style: CustomColors.getBodySmall(
                    context,
                    CustomColors.getSecondaryText(context),
                  ),
                ),
                Text(
                  'ФИО: ${employee.user.getFullName()}',
                  style: CustomColors.getBodySmall(
                    context,
                    CustomColors.getSecondaryText(context),
                  ),
                ),
                Text(
                  'Тел.: ${employee.user.phone}',
                  style: CustomColors.getBodySmall(
                    context,
                    CustomColors.getSecondaryText(context),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Роль: ',
                      style: CustomColors.getBodySmall(
                        context,
                        CustomColors.getSecondaryText(context),
                      ),
                    ),
                    RoleTooltip(
                      role: employee.role,
                      style: CustomColors.getBodySmall(
                        context,
                        CustomColors.getSecondaryText(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (GetIt.I.get<OrganizationService>().isEditor(
              ScopeType.ORGANIZATION_UPDATE,
            ))
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(3, 0, 3, 3),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            hide();
                            EmployeeDialog.show(context, employee);
                          },
                          iconSize: 16,
                          color: CustomColors.getSecondaryText(context),
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        );
      },
      child: Text(
        employee.user.name,
        style: style ?? CustomColors.getBodyLarge(context, null),
      ),
    );
  }
}
