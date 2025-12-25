import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';

class CustomSkeleton extends StatelessWidget {
  final Widget child;

  const CustomSkeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColors.getAlternate(context),
      highlightColor: CustomColors.getAlternate(context).withAlpha(10),
      period: const Duration(milliseconds: 1500), // Скорость пробега блика
      child: child,
    );
  }

  static Widget panel({double? width, double? height, double? padding}) {
    return Padding(
      padding: EdgeInsetsGeometry.all(padding ?? 2),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
