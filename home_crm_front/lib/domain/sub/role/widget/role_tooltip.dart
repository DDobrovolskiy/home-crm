import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_dto.dart';
import 'package:home_crm_front/domain/sub/role/widget/role_dialog.dart';
import 'package:home_crm_front/domain/sub/scope/scope.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/tooltip/custom_tooltip_host.dart';
import '../../organization/service/organization_service.dart';

class RoleTooltip extends StatelessWidget {
  final RoleDto role;
  final TextStyle? style;

  const RoleTooltip({super.key, required this.role, this.style});

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
                  'Описание: ${role.description}',
                  style: CustomColors.getBodySmall(
                    context,
                    CustomColors.getSecondaryText(context),
                  ),
                ),
                Text(
                  'Разрешения:',
                  style: CustomColors.getBodySmall(
                    context,
                    CustomColors.getSecondaryText(context),
                  ),
                ),
                if (role.owner)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                    child: Text(
                      '- [без ограничений]',
                      style: CustomColors.getBodySmall(
                        context,
                        CustomColors.getSecondaryText(context),
                      ),
                    ),
                  ),
                if (!role.owner)
                  for (final scope in role.scopes)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                      child: Text(
                        '- ${scope.description}',
                        style: CustomColors.getBodySmall(
                          context,
                          CustomColors.getSecondaryText(context),
                        ),
                      ),
                    ),
              ],
            ),
            if (!role.owner &&
                GetIt.I.get<OrganizationService>().isEditor(
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
                            RoleDialog.show(context, role);
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
        role.name,
        style: style ?? CustomColors.getBodyLarge(context, null),
      ),
    );
  }
}
