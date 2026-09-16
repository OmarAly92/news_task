import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_svg_image.dart';

class AppNavBarItem extends StatelessWidget {
  const AppNavBarItem({
    super.key,
    required this.iconPath,
    required this.labelKey,
    required this.isActive,
    required this.onTap,
  });

  final String iconPath;
  final String labelKey;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? context.skin.navBarItemActive
        : context.skin.navBarItemInactive;
    return Semantics(
      button: true,
      selected: isActive,
      label: labelKey.tr(),
      child: AppInkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: AppMotion.base,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isActive
                    ? context.skin.navBarIndicator
                    : context.skin.navBarBackground,
                borderRadius: BorderRadius.circular(AppConstants.radiusPill),
              ),
              child: AppSvgImage(path: iconPath, size: 24, color: color),
            ),
            const VerticalSpace(4),
            AppText(
              labelKey.tr(),
              style: AppTextStyle.style12SemiBold.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
