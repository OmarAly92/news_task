import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/app_pop_icon.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:news_task/core/widgets/main_widgets/primary_button.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class ArticleUnavailableView extends StatelessWidget {
  const ArticleUnavailableView({super.key, this.reason});

  final String? reason;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return Column(
      children: [
        Padding(
          padding: .symmetric(horizontal: 8),
          child: GlobalAppbar.sub(
            leading: Center(
              child: Material(
                color: context.skin.surface.withValues(alpha: 0.9),
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: const AppPopIcon(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: skin.card,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.article_outlined,
                      size: 40,
                      color: skin.textMuted,
                    ),
                  ),
                  const VerticalSpace(20),
                  AppText.multiline(
                    LocaleKeys.articleUnavailable.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.headingSm,
                  ),
                  if (reason == 'removed_by_publisher') ...[
                    const VerticalSpace(8),
                    AppText.multiline(
                      LocaleKeys.removedByPublisher.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodySm.copyWith(
                        color: skin.textSecondary,
                      ),
                    ),
                  ],
                  const VerticalSpace(24),
                  PrimaryButton(
                    text: LocaleKeys.goBack.tr(),
                    onPressed: context.pop,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
