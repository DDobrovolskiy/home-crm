import 'package:flutter/cupertino.dart';

import '../../widgets/stamp.dart';

class CustomLoad<T> extends StatefulWidget {
  final Future<T> value;
  final Widget Function(T) builder;

  static CustomLoad<T> load<T>(Future<T> value, Widget Function(T) builder) {
    return CustomLoad(builder: builder, value: value);
  }

  const CustomLoad({super.key, required this.builder, required this.value});

  @override
  _CustomLoadState<T> createState() => _CustomLoadState();
}

class _CustomLoadState<T> extends State<CustomLoad<T>> {
  late Widget result;

  @override
  void initState() {
    super.initState();
    result = Stamp.loadWidget(context);
    widget.value
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
  Widget build(BuildContext context) {
    return result;
  }
}
