import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class AppStaleBanner extends StatelessWidget {
  const AppStaleBanner({super.key, this.message, this.onRetry});

  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return AnimatedSize(
      duration: AppMotion.slow,
      curve: AppMotion.easeOut,
      alignment: Alignment.topCenter,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                color: skin.warningLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(Icons.history_rounded, size: 16, color: skin.warning),
                    const HorizontalSpace(8),
                    Expanded(
                      child: AppText(
                        message!,
                        style: AppTextStyle.caption.copyWith(
                          color: skin.warning,
                        ),
                      ),
                    ),
                    if (onRetry != null)
                      IconButton(
                        onPressed: onRetry,
                        tooltip: LocaleKeys.retry.tr(),
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(
                          width: 48,
                          height: 48,
                        ),
                        icon: Icon(
                          Icons.refresh_rounded,
                          size: 18,
                          color: skin.warning,
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
