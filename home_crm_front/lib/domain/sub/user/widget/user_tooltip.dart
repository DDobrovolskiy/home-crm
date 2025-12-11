import 'package:flutter/cupertino.dart';

import '../../../../theme/theme.dart';
import '../../../support/components/tooltip/custom_tooltip_host.dart';
import '../dto/user_dto.dart';

class UserTooltip extends StatelessWidget {
  final UserDto user;
  final TextStyle? style;

  const UserTooltip({super.key, required this.user, this.style});

  @override
  Widget build(BuildContext context) {
    return CustomTooltipHost(
      tooltipContent: (hide) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${user.id}',
              style: CustomColors.getBodySmall(
                context,
                CustomColors.getSecondaryText(context),
              ),
            ),
            Text(
              'Телефон: ${user.phone}',
              style: CustomColors.getBodySmall(
                context,
                CustomColors.getSecondaryText(context),
              ),
            ),
          ],
        );
      },
      child: Text(
        user.name,
        style: style ?? CustomColors.getBodyLarge(context, null),
      ),
    );
  }
}
