import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/primary_button.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class AppInitialStateWidget extends StatelessWidget {
  const AppInitialStateWidget({
    super.key,
    required this.onRefresh,
    this.message,
    this.icon,
  });

  final VoidCallback onRefresh;
  final String? message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.refresh,
              size: 64,
              color: context.skin.textMuted,
            ),
            const VerticalSpace(16),
            AppText.multiline(
              message ?? LocaleKeys.nothingToDisplayHere.tr(),
              style: AppTextStyle.style16SemiBold.copyWith(
                color: context.skin.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(24),
            PrimaryButton(text: LocaleKeys.refresh.tr(), onPressed: onRefresh),
          ],
        ),
      ),
    );
  }
}
