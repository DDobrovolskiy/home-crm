import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:home_crm_front/domain/support/components/aggregate/aggregate.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../widgets/stamp.dart';

class CustomLoad<T extends Loader> extends StatefulWidget {
  final LoadStore<T?>? loader;
  final Widget Function(BuildContext, T) builder;
  final Widget skeleton;
  final Widget? skeletonError;

  static CustomLoad<T> load<T extends Loader>({
    required LoadStore<T?>? loader,
    required Widget Function(BuildContext, T) builder,
    required Key key,
    required Widget skeleton,
    Widget? skeletonError,
  }) {
    return CustomLoad(
      key: key,
      builder: builder,
      loader: loader,
      skeleton: skeleton,
      skeletonError: skeletonError,
    );
  }

  const CustomLoad({
    super.key,
    required this.builder,
    required this.loader,
    required this.skeleton,
    this.skeletonError,
  });

  @override
  _CustomLoadState<T> createState() => _CustomLoadState();
}

class _CustomLoadState<T extends Loader> extends State<CustomLoad<T>> {
  late Widget Function(BuildContext) result;

  @override
  void initState() {
    super.initState();
    if (mounted && widget.loader != null) {
      result = (c) => widget.skeleton;
      widget.loader?.callback.subscribe(hashCode, () {
        widget.loader
            ?.value()
            .then((v) {
              if (!mounted) return;
              setState(() {
                if (v == null || v.load) {
                  result = (c) => widget.skeleton;
                } else {
                  result = (c) => widget.builder(c, v);
                }
              });
            })
            .onError((e, stack) {
              if (!mounted) return;
              setState(() {
                result = (c) => widget.skeletonError ?? Stamp.errorWidget(c);
              });
            });
      });
      widget.loader
          ?.value()
          .then((v) {
            if (!mounted) return;
            setState(() {
              if (v == null || v.load) {
                result = (c) => widget.skeleton;
              } else {
                result = (c) => widget.builder(c, v);
              }
            });
          })
          .onError((e, stack) {
            if (!mounted) return;
            setState(() {
              result = (c) => widget.skeletonError ?? Stamp.errorWidget(c);
            });
          });
    }
  }

  @override
  void dispose() {
    widget.loader?.callback.unSubscribe(hashCode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loader == null) {
      return SizedBox.shrink();
    }
    return result(context);
  }
}
////////////////////////////////////////////////////////////////////////
class CustomLoadList<T> extends StatefulWidget {
  final LoadStore<T?>? loader;
  final Widget Function(BuildContext, T) builder;
  final Widget skeleton;
  final Widget? skeletonError;

  static CustomLoadList<T> load<T>({
    required LoadStore<T?>? loader,
    required Widget Function(BuildContext, T) builder,
    required Key key,
    required Widget skeleton,
    Widget? skeletonError,
  }) {
    return CustomLoadList(
      key: key,
      builder: builder,
      loader: loader,
      skeleton: skeleton,
      skeletonError: skeletonError,
    );
  }

  const CustomLoadList({
    super.key,
    required this.builder,
    required this.loader,
    required this.skeleton,
    this.skeletonError,
  });

  @override
  _CustomLoadListState<T> createState() => _CustomLoadListState();
}

class _CustomLoadListState<T> extends State<CustomLoadList<T>> {
  late Widget Function(BuildContext) result;

  @override
  void initState() {
    super.initState();
    if (mounted && widget.loader != null) {
      result = (c) => widget.skeleton;
      widget.loader?.callback.subscribe(hashCode, () {
        widget.loader
            ?.value()
            .then((v) {
              if (!mounted) return;
              setState(() {
                if (v == null) {
                  result = (c) => widget.skeleton;
                } else {
                  result = (c) => widget.builder(c, v as T);
                }
              });
            })
            .onError((e, stack) {
              if (!mounted) return;
              setState(() {
                result = (c) => widget.skeletonError ?? Stamp.errorWidget(c);
              });
            });
      });
      widget.loader
          ?.value()
          .then((v) {
            if (!mounted) return;
            setState(() {
              if (v == null) {
                result = (c) => widget.skeleton;
              } else {
                result = (c) => widget.builder(c, v as T);
              }
            });
          })
          .onError((e, stack) {
            if (!mounted) return;
            setState(() {
              result = (c) => widget.skeletonError ?? Stamp.errorWidget(c);
            });
          });
    }
  }

  @override
  void dispose() {
    widget.loader?.callback.unSubscribe(hashCode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loader == null) {
      return SizedBox.shrink();
    }
    return result(context);
  }
}

////////////////////////////////////////////////////////////////////////
class CustomTableLoadSliver<T extends Loader> extends StatefulWidget {
  final Widget Function(BuildContext, List<T?>) head;
  final LoadStore<List<T?>> loader;
  final Widget Function(BuildContext, int, T) builder;
  final Widget? skeleton;
  final Widget? skeletonError;
  final Widget? footer;
  final Function(List<T?>)? onLoad;

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

class _CustomTableLoadSliverState<T extends Loader>
    extends State<CustomTableLoadSliver<T>> {
  bool _isLoading = true;
  List<T?> _items = [];

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
      sliver: MultiSliver(children: [_table(context)]),
    );
  }

  Widget _table(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        var item = _items[index];
        if (index > 20) {
          if (item == null || item.load) {
            return widget.skeleton ?? Stamp.loadWidget(context);
          } else {
            return widget.builder(context, index, item);
          }
        }
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            verticalOffset: 50.0, // Вылет снизу
            child: FadeInAnimation(
              child: (item == null || item.load)
                  ? widget.skeleton ?? Stamp.loadWidget(context)
                  : widget.builder(context, index, item),
            ),
          ),
        );
      }, childCount: _items.length),
    );
  }
}

class LoadStore<T> {
  final Future<T> Function() value;
  final LoadCallback callback;

  const LoadStore({required this.value, required this.callback});
}

//
class LoadCallback {
  final Map<int, Function> subscribers = {};

  void subscribe(int hash, Function func) {
    subscribers[hash] = func;
  }

  void unSubscribe(int hash) {
    subscribers.remove(hash);
  }

  void call() {
    for (var f in subscribers.values) {
      f();
    }
  }
}
