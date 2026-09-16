import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.children,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  final List<Widget> children;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 290,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.skin.dialogBackground,
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppConstants.radiusXl),
        ),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
    );
  }
}
