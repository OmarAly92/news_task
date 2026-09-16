import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.text,
    this.icon,
    this.neutral = false,
    this.overlay = false,
  });

  const AppBadge.neutral({
    super.key,
    required this.text,
    this.icon,
    this.neutral = true,
    this.overlay = false,
  });

  const AppBadge.overlay({
    super.key,
    required this.text,
    this.icon,
    this.neutral = false,
    this.overlay = true,
  });

  final String text;
  final IconData? icon;
  final bool neutral;
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final foreground = overlay
        ? skin.primaryDark
        : neutral
        ? skin.textSecondary
        : skin.chipText;
    final background = overlay
        ? skin.surfaceElevated.withValues(alpha: 0.94)
        : neutral
        ? skin.card
        : skin.chipBackground;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        boxShadow: overlay
            ? [
                BoxShadow(
                  color: skin.shadow,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foreground),
            const HorizontalSpace(4),
          ],
          AppText(text, style: AppTextStyle.badge.copyWith(color: foreground)),
        ],
      ),
    );
  }
}
