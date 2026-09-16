import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/app_themes/text_style/font_weight_helper.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class SuggestionChip extends StatelessWidget {
  const SuggestionChip({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.semanticLabel,
  });

  final String text;
  final IconData? icon;
  final void Function()? onTap;
  final bool isSelected;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppConstants.radiusPill);
    final foreground = isSelected
        ? context.skin.primaryDark
        : context.skin.textSecondary;
    return Semantics(
      button: true,
      selected: isSelected,
      label: semanticLabel ?? text,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: AppInkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: AppMotion.easeOut,
              constraints: const BoxConstraints(minHeight: 40),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.skin.primaryLight
                    : context.skin.surface,
                borderRadius: radius,
                border: Border.all(
                  color: isSelected
                      ? context.skin.primaryDark
                      : context.skin.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 14, color: foreground),
                    const HorizontalSpace(6),
                  ],
                  AppText(
                    text,
                    style: AppTextStyle.bodySm.copyWith(
                      fontWeight: FontWeightHelper.medium,
                      color: foreground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
