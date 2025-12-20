import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class CustomTableRow extends StatelessWidget {
  final List<Widget> cells;
  final bool hover;
  final String? error;

  const CustomTableRow({
    super.key,
    required this.cells,
    this.hover = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: hover
            ? CustomColors.getPrimaryBackground(context)
            : CustomColors.getSecondaryBackground(context),
        boxShadow: [
          // BoxShadow(
          //   blurRadius: 4,
          //   color: CustomColors.getLineColor(context),
          //   offset: Offset(0, 1),
          // ),
        ],
        // borderRadius: error != null
        //     ? BorderRadius.all(Radius.circular(8))
        //     : null,
        border: error != null
            ? Border.fromBorderSide(
                BorderSide(color: CustomColors.getError(context), width: 2),
              )
            : Border(
                top: BorderSide(
                  color: CustomColors.getLineColor(context),
                  width: 1,
                ),
              ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(mainAxisSize: MainAxisSize.max, children: cells),
            if (error != null)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    error!,
                    style: CustomColors.getBodySmall(
                      context,
                      CustomColors.getError(
                        context,
                      ).withBlue(150).withGreen(150),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
