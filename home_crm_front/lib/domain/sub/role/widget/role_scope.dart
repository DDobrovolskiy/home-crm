import 'package:flutter/cupertino.dart';

import '../../../../theme/theme.dart';
import '../dto/response/role_dto.dart';

class RoleScopes extends StatelessWidget {
  final RoleDto role;
  final TextStyle? style;

  const RoleScopes({super.key, required this.role, this.style});

  @override
  Widget build(BuildContext context) {
    if (role.owner) {
      return Text(
        '- [без ограничений]',
        style:
            style ??
            CustomColors.getBodySmall(
              context,
              CustomColors.getSecondaryText(context),
            ),
      );
    } else if (!role.owner && role.scopes.isEmpty) {
      return Text(
        '- [отсутствуют]',
        style:
            style ??
            CustomColors.getBodySmall(
              context,
              CustomColors.getSecondaryText(context),
            ),
      );
    } else if (!role.owner) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final scope in role.scopes)
            Text(
              '- ${scope.description}',
              style:
                  style ??
                  CustomColors.getBodySmall(
                    context,
                    CustomColors.getSecondaryText(context),
                  ),
            ),
        ],
      );
    } else {
      return Container();
    }
  }
}
