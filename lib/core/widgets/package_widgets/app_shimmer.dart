import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, required this.child, this.enabled = false});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: context.skin.shimmerBase,
      highlightColor: context.skin.shimmerHighlight,
      child: child,
    );
  }
}
