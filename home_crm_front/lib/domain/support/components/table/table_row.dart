import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class CustomTableRow extends StatelessWidget {
  final List<Widget> cells;
  final bool hover;

  const CustomTableRow({super.key, required this.cells, this.hover = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: hover
              ? CustomColors.getPrimaryBackground(context)
              : CustomColors.getSecondaryBackground(context),
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
