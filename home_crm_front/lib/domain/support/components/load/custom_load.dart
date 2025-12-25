import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/stamp.dart';

class CustomLoad<T> extends StatefulWidget {
  final LoadStore<T> loader;
  final Widget Function(BuildContext, T) builder;
  final Widget? skeleton;
  final Widget? skeletonError;

  static CustomLoad<T> load<T>(LoadStore<T> loader,
      Widget Function(BuildContext, T) builder,
      {Key? key, Widget? skeleton, Widget? skeletonError}) {
    return CustomLoad(key: key,
        builder: builder,
        loader: loader,
        skeleton: skeleton,
        skeletonError: skeletonError);
  }

  const CustomLoad(
      {super.key, required this.builder, required this.loader, this.skeleton, this.skeletonError,});

  @override
  _CustomLoadState<T> createState() => _CustomLoadState();
}

class _CustomLoadState<T> extends State<CustomLoad<T>> {
  late Widget Function(BuildContext) result;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      result = (c) => widget.skeleton ?? Stamp.loadWidget(c);
      widget.loader.callback.subscribe(hashCode, () {
        widget.loader.value()
            .then((v) {
          if (!mounted) return;
          setState(() {
            result = (c) => widget.builder(c, v);
          });
        })
            .onError((e, stack) {
          if (!mounted) return;
          setState(() {
            result = (c) => widget.skeletonError ?? Stamp.errorWidget(c);
          });
        });
      });
      widget.loader.value()
          .then((v) {
        if (!mounted) return;
        setState(() {
          result = (c) => widget.builder(c, v);
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
    widget.loader.callback.unSubscribe(hashCode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return result(context);
  }
}

class LoadStore<T> {
  final Future<T> Function() value;
  final LoadCallback callback;

  const LoadStore({
    required this.value,
    required this.callback,
  });

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