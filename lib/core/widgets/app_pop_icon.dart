import 'package:flutter/material.dart';
import 'package:news_task/core/utils/extensions.dart';

class AppPopIcon extends StatelessWidget {
  const AppPopIcon({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => context.pop(),
      icon: Transform.rotate(
        angle: context.isArabic ? 3.14 : 0,
        child: Padding(
          padding: EdgeInsetsGeometry.directional(end: 3),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
    );
  }
}
