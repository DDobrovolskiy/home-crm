import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/common/logo.png'
              : 'assets/common/logo.png',
          width: 44,
          height: 44,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}
