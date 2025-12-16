import 'package:flutter/cupertino.dart';

class CustomTableHeadRow extends StatelessWidget {
  final List<Widget> cells;

  const CustomTableHeadRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12, 6, 12, 6),
      child: Row(mainAxisSize: MainAxisSize.max, children: cells),
    );
  }
}
