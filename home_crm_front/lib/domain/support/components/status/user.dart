import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class UserStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 6, 0, 6),
      child: Container(
        width: 160,
        height: 32,
        decoration: BoxDecoration(
          color: CustomColors.getSuccess(context).withAlpha(100),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: AlignmentDirectional(0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
              child: Icon(
                Icons.stars_rounded,
                color: CustomColors.getSuccess(context),
                size: 24,
              ),
            ),
            Text(
              'Подтверждён',
              style: CustomColors.getBodyMedium(context, null),
            ),
          ],
        ),
      ),
    );
  }
}
