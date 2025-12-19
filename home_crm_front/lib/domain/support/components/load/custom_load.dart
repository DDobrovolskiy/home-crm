import 'package:flutter/cupertino.dart';

import '../../widgets/stamp.dart';

class CustomLoad<T> extends StatefulWidget {
  final LoadStore<T> loader;
  final Widget Function(BuildContext, T) builder;

  static CustomLoad<T> load<T>(LoadStore<T> loader,
      Widget Function(BuildContext, T) builder) {
    return CustomLoad(builder: builder, loader: loader,);
  }

  const CustomLoad({super.key, required this.builder, required this.loader,});

  @override
  _CustomLoadState<T> createState() => _CustomLoadState();
}

class _CustomLoadState<T> extends State<CustomLoad<T>> {
  late Widget Function(BuildContext) result;

  @override
  void initState() {
    super.initState();
    result = (c) => Stamp.loadWidget(c);
    widget.loader.callback.subscribe(hashCode, () {
      widget.loader.value()
          .then((v) {
        setState(() {
          result = (c) => widget.builder(c, v);
        });
      })
          .onError((e, stack) {
        setState(() {
          result = (c) => Stamp.errorWidget(c);
        });
      });
    });
    widget.loader.value()
        .then((v) {
      setState(() {
        result = (c) => widget.builder(c, v);
      });
    })
        .onError((e, stack) {
      setState(() {
        result = (c) => Stamp.errorWidget(c);
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
    widget.loader.callback.unSubscribe(hashCode);
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