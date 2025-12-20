import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';

import '../../../../theme/theme.dart';

class CustomTable extends StatelessWidget {
  final CustomTableHeadRow head;
  final List<Widget> rows;

  const CustomTable({super.key, required this.head, required this.rows});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxHeight < 150) {
          return SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: CustomColors.getSecondaryBackground(context),
              // boxShadow: [
              //   BoxShadow(
              //     // blurRadius: 4,
              //     color: Color(0x1F000000),
              //     offset: Offset(0.0, 1),
              //   ),
              // ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CustomColors.getLineColor(context),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  head,
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(children: [for (final row in rows) row]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
