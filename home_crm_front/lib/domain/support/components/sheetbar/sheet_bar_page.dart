import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../theme/theme.dart';
import '../callback/NavBarCallBack.dart';
import '../screen/Screen.dart';

abstract class SheetPage extends StatefulWidget {
  const SheetPage({super.key});

  String getName();
}

abstract class SheetPageState<T, D extends SheetPage, S extends StatefulWidget>
    extends State<S>
    with AutomaticKeepAliveClientMixin<S> {
  bool showSidePanel = true;
  Set<int> selectIds = {};
  T? selected;

  @override
  bool get wantKeepAlive => true;

  D show(T selected, {bool isSidePanel = false});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                sliver: MultiSliver(
                  children: [_sliverLabel(context), sliverTable(context)],
                ),
              ),
            ],
          ),
        ),
        ..._sidePanels(context),
      ],
    );
  }

  List<Widget> _sidePanels(BuildContext context) {
    if (selected != null && Screen.isSidePanel(context)) {
      return [
        Column(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showSidePanel = !showSidePanel;
                });
              },
              icon: Icon(
                showSidePanel
                    ? Icons.keyboard_double_arrow_right
                    : Icons.keyboard_double_arrow_left,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  GetIt.I.get<SheetElementAddCallback>().call(
                    show(selected as T),
                  );
                });
              },
              icon: Icon(Icons.open_in_browser),
            ),
          ],
        ),
        if (showSidePanel && selected != null)
          SizedBox(width: 700.0, child: show(selected as T, isSidePanel: true)),
      ];
    } else {
      return [];
    }
  }

  Widget _sliverLabel(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        color: CustomColors.getPrimaryBackground(context),
        child: customLabels(context),
      ),
    );
  }

  Widget customLabels(BuildContext context);

  Widget sliverTable(BuildContext context);
}
