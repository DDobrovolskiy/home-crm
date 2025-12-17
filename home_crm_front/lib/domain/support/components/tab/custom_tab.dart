import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';
import '../text/custom_text_label.dart';

class CustomTab extends StatefulWidget {
  final List<CustomTabView> contents;
  final TabController tabController;

  const CustomTab({
    super.key,
    required this.contents,
    required this.tabController,
  });

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Наш динамический TabBar
        Container(
          decoration: BoxDecoration(
            color: CustomColors.getSecondaryBackground(context),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: TabBar(
            tabAlignment: TabAlignment.startOffset,
            controller: widget.tabController,
            isScrollable: true,
            labelColor: CustomColors.getPrimaryText(context),
            unselectedLabelColor: CustomColors.getSecondaryText(context),
            labelStyle: CustomColors.getTitleMedium(context, null),
            indicatorColor: CustomColors.getPrimary(context),
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: CustomColors.getAlternate(context),
            dividerHeight: 2,
            splashBorderRadius: BorderRadius.circular(12),
            overlayColor: WidgetStateProperty.all(
              CustomColors.getPrimaryBackground(context),
            ),
            tabs: widget.contents
                .map(
                  (title) =>
                  Tab(
                    child: Row(
                      children: [
                        // Text(title.name),
                        CustomLabelCircleText(
                          text: Text(title.name),
                          number: title.label != null ? title.label!() : null,
                        ),
                      ],
                    ),
                  ),
            )
                .toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: widget.contents.map((page) {
              // Создаем контент для каждой вкладки динамически
              return Container(
                color: CustomColors.getSecondaryBackground(context),
                child: SingleChildScrollView(child: page),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CustomTabView extends StatefulWidget {
  final String name;
  final Widget child;
  final int Function()? label;

  const CustomTabView(
      {super.key, required this.name, required this.child, this.label});

  @override
  _CustomTabViewState createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with AutomaticKeepAliveClientMixin<CustomTabView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
