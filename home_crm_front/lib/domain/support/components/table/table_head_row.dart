import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row_cell.dart';

class CustomTableHeadRow extends StatelessWidget {
  final List<CustomTableHeadRowCell> cells;

  const CustomTableHeadRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
      child: Row(mainAxisSize: MainAxisSize.max, children: cells),
    );
  }
}
