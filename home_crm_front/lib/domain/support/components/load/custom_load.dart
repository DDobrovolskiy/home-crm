import 'package:flutter/cupertino.dart';

import '../../widgets/stamp.dart';

class CustomLoad<T> extends StatefulWidget {
  final LoadStore<T> loader;
  final Widget Function(T) builder;

  static CustomLoad<T> load<T>(LoadStore<T> loader,
      Widget Function(T) builder) {
    return CustomLoad(builder: builder, loader: loader,);
  }

  const CustomLoad({super.key, required this.builder, required this.loader,});

  @override
  _CustomLoadState<T> createState() => _CustomLoadState();
}

class _CustomLoadState<T> extends State<CustomLoad<T>> {
  late Widget result;

  @override
  void initState() {
    super.initState();
    result = Stamp.loadWidget(context);
    widget.loader.callback.subscribe(hashCode, () {
      widget.loader.value()
          .then((v) {
        setState(() {
          result = widget.builder(v);
        });
      })
          .onError((e, stack) {
        setState(() {
          result = Stamp.errorWidget(context);
        });
      });
    });
    widget.loader.value()
        .then((v) {
      setState(() {
        result = widget.builder(v);
      });
    })
        .onError((e, stack) {
      setState(() {
        result = Stamp.errorWidget(context);
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
    return result;
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