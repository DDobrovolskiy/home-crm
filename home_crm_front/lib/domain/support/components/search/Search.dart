import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.getPrimaryBackground(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              color: CustomColors.getSecondaryText(context),
              size: 28,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Text(
                'Search',
                style: CustomColors.getLabelLarge(context, null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
