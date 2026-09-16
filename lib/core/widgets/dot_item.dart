import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class DotItem extends StatelessWidget {
  const DotItem({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.base,
      curve: AppMotion.easeOut,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 6,
      width: isActive ? 22 : 6,
      decoration: BoxDecoration(
        color: isActive
            ? context.skin.pageIndicatorActive
            : context.skin.pageIndicatorInactive,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
      ),
    );
  }
}
