import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/domain/support/components/table/table_row_cell.dart';

class CustomTableRow extends StatelessWidget {
  final List<CustomTableRowCell> cells;

  const CustomTableRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(mainAxisSize: MainAxisSize.max, children: cells),
    );
  }
}
