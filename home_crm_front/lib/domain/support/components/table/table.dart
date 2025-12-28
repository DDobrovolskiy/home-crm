import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../theme/theme.dart';

class CustomTable extends StatelessWidget {
  final CustomTableHeadRow head;
  final List<Widget> rows;

  const CustomTable({super.key, required this.head, required this.rows});

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     if (constraints.maxHeight < 150) {
    //       return SizedBox.shrink();
    //     }
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
      child: Container(
        // width: MediaQuery.sizeOf(context).width,
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
          child: CustomScrollView(
            // Если нужно, чтобы скролл занимал минимум места (аналог MainAxisSize.min),
            // воспользуйтесь свойством shrinkWrap у самого CustomScrollView.
            shrinkWrap: true,
            slivers: [
              SliverPinnedHeader(
                child: head, // head просто застынет на месте
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => rows[index],
                  childCount: rows.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   },
    // );
  }
}

class CustomTableSliver extends StatelessWidget {
  final Widget head;
  final List<Widget> rows;

  const CustomTableSliver({super.key, required this.head, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: head,
      sliver: MultiSliver(
        children: [
          _table(context),
        ],
      ),
    );
  }

  Widget _table(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index > 20) {
          return rows[index];
        }
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            verticalOffset: 50.0, // Вылет снизу
            child: FadeInAnimation(
              child: rows[index],
            ),
          ),
        );
      }, childCount: rows.length),
    );
  }
}
