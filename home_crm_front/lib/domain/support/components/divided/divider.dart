import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

Widget getHorizontalDivider(BuildContext context) {
  return Divider(
    height: 12,
    thickness: 2,
    color: CustomColors.getAlternate(context),
  );
}

Widget getVerticalDivider(BuildContext context) {
  return VerticalDivider(
    width: 12,
    thickness: 2,
    color: CustomColors.getAlternate(context),
  );
}
