import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

class SheetElement extends StatefulWidget {
  final bool isSelected;

  const SheetElement({super.key, required this.isSelected});

  @override
  _SheetElementState createState() => _SheetElementState();
}

class _SheetElementState extends State<SheetElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? CustomColors.getPrimary(context)
              : CustomColors.getAlternate(context),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x34090F13),
              offset: Offset(0.0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CustomColors.getAlternate(context),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 6, 6, 6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TEST',
                style: CustomColors.getTitleMedium(context, Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
