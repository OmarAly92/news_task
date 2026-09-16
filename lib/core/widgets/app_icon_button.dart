import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 38,
    this.iconColor,
  });

  final IconData icon;
  final void Function()? onTap;
  final double size;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppConstants.radiusPill);
    return Material(
      color: context.skin.surface,
      borderRadius: radius,
      child: AppInkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: context.skin.border),
          ),
          child: Icon(
            icon,
            size: size * 0.5,
            color: iconColor ?? context.skin.textSecondary,
          ),
        ),
      ),
    );
  }
}
