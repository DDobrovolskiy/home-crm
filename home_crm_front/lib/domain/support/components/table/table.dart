import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:home_crm_front/domain/support/components/table/table_head_row.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../theme/theme.dart';
import '../../widgets/stamp.dart';
import '../load/custom_load.dart';

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

class CustomTableLoadSliver<T> extends StatefulWidget {
  final Widget Function(BuildContext, List<T>) head;
  final LoadStore<List<T>> loader;
  final Widget Function(BuildContext, int, T) builder;
  final Widget? skeleton;
  final Widget? skeletonError;
  final Widget? footer;
  final Function(List<T>)? onLoad;

  const CustomTableLoadSliver({
    super.key,
    required this.head,
    required this.loader,
    required this.builder,
    this.skeleton,
    this.skeletonError,
    this.footer,
    this.onLoad,
  });

  @override
  State<CustomTableLoadSliver<T>> createState() =>
      _CustomTableLoadSliverState<T>();
}

class _CustomTableLoadSliverState<T> extends State<CustomTableLoadSliver<T>> {
  bool _isLoading = true;
  List<T> _items = [];

  @override
  void initState() {
    super.initState();
    _loading();
  }

  @override
  void dispose() {
    widget.loader.callback.unSubscribe(hashCode);
    super.dispose();
  }

  // загрузка данных
  void _loading() {
    if (mounted) {
      widget.loader.callback.subscribe(hashCode, () {
        widget.loader.value().then((v) {
          if (!mounted) return;
          setState(() {
            _items = v;
            if (widget.onLoad != null) {
              widget.onLoad!(v);
            }
          });
        });
      });
      widget.loader.value().then((v) {
        if (!mounted) return;
        setState(() {
          _items = v;
          if (widget.onLoad != null) {
            widget.onLoad!(v);
          }
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      // 1. Хеадер, который будет «прилипать»
      header: Container(child: widget.head(context, _items)),
      sliver: MultiSliver(
        children: [
          // SliverAnimatedSwitcher(
          //   switchInCurve: Curves.easeInOut,
          //   switchOutCurve: Curves.easeInOut,
          //   reverseDuration: Duration(seconds: 30),
          //   duration: Duration(seconds: 30),
          //   // child:  _table(context),
          //   child: _isLoading ? _tableSkeleton(context) : _table(context),
          // ),
          _table(context),
          // SliverToBoxAdapter(child: widget.footer ?? CustomTableFooterRow(child: SizedBox.shrink()),)
        ],
      ),
    );
  }

  Widget _table(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index > 20) {
          return widget.builder(context, index, _items[index]);
        }
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            verticalOffset: 50.0, // Вылет снизу
            child: FadeInAnimation(
              child: widget.builder(context, index, _items[index]),
            ),
          ),
        );
      }, childCount: _items.length),
    );
  }

  Widget _table1(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => widget.builder(context, index, _items[index]),
        childCount: _items.length,
      ),
    );
  }

  Widget _tableSkeleton(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => widget.skeleton ?? Stamp.loadWidget(context),
        childCount: 10,
      ),
    );
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

