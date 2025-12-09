import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class CustomTableRow extends StatelessWidget {
  final List<Widget> cells;

  const CustomTableRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.getSecondaryBackground(context),
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              color: CustomColors.getLineColor(context),
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(mainAxisSize: MainAxisSize.max, children: cells),
        ),
      ),
    );
  }
}
