import 'package:flutter/cupertino.dart';

import '../../../../theme/theme.dart';
import 'hovered_region.dart';

class CustomButtonLink extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function() onPressed;

  const CustomButtonLink({
    super.key,
    required this.text,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return HoveredRegion(
      onTap: onPressed,
      child: (isHovered) {
        return Text(
          text,
          style: isHovered
              ? textStyle
              : textStyle.copyWith(color: CustomColors.getPrimary(context)),
        );
      },
    );
  }
}
