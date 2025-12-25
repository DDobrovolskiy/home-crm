import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class CustomTableHeadRow extends StatelessWidget {
  final List<Widget> cells;

  const CustomTableHeadRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.getSecondaryBackground(context),
        // borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        border: Border(
          top: BorderSide(
            color: CustomColors.getLineColor(context),
            width: 1,
          ),
          left: BorderSide(
            color: CustomColors.getLineColor(context),
            width: 1,
          ),
          right: BorderSide(
            color: CustomColors.getLineColor(context),
            width: 1,
          ),
        ),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(mainAxisSize: MainAxisSize.max, children: cells),
      ),
    );
  }
}

class CustomTableFooterRow extends StatelessWidget {
  final Widget child;

  const CustomTableFooterRow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.getSecondaryBackground(context),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        border: Border(
          bottom: BorderSide(
            color: CustomColors.getLineColor(context),
            width: 1,
          ),
          left: BorderSide(
            color: CustomColors.getLineColor(context),
            width: 1,
          ),
          right: BorderSide(
            color: CustomColors.getLineColor(context),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: child,
      ),
    );
  }
}
