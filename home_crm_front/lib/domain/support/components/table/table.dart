import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';
import 'package:home_crm_front/domain/support/components/table/table_row.dart';

import '../../../../theme/theme.dart';

class CustomTable extends StatelessWidget {
  final CustomTableHeadRow head;
  final List<CustomTableRow> rows;

  const CustomTable({super.key, required this.head, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 44),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: CustomColors.getSecondaryBackground(context),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x1F000000),
              offset: Offset(0.0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: CustomColors.getPrimaryBackground(context),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [head, for (final row in rows) row],
          ),
        ),
      ),
    );
  }
}
