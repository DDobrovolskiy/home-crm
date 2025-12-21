import 'package:flutter/cupertino.dart';

class CustomTableHeadRow extends StatelessWidget {
  final List<Widget> cells;

  const CustomTableHeadRow({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(mainAxisSize: MainAxisSize.max, children: cells),
    );
  }
}
