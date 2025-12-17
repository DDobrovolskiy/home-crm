import 'package:flutter/cupertino.dart';

class CustomTableHeadRow extends StatelessWidget {
  final List<Widget> cells;

  const CustomTableHeadRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
      child: Row(mainAxisSize: MainAxisSize.max, children: cells),
    );
  }
}
