import 'package:easy_localization/easy_localization.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';

class ArticleContentBlock extends StatelessWidget {
  const ArticleContentBlock({
    super.key,
    this.type,
    this.text,
    this.url,
    this.caption,
  });

  final String? type;
  final String? text;
  final String? url;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return switch (type) {
      'paragraph' when text != null => Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: AppText.multiline(
          text!,
          style: AppTextStyle.bodyLg.copyWith(height: 1.65),
        ),
      ),
      'heading' when text != null => Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 12),
        child: AppText.multiline(text!, style: AppTextStyle.headingSm),
      ),
      'quote' when text != null => Container(
        margin: const EdgeInsets.only(bottom: 22),
        padding: const EdgeInsets.fromLTRB(14, 12, 16, 12),
        decoration: BoxDecoration(
          color: skin.card,
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: skin.primary,
                  borderRadius: BorderRadius.circular(AppConstants.radiusPill),
                ),
              ),
              const HorizontalSpace(14),
              Expanded(
                child: AppText.multiline(
                  '“$text”',
                  style: AppTextStyle.headingSm.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: skin.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      'image' when url != null => Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusXl),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: AppNetworkImage(
                  url!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  semanticLabel: (caption ?? '').isNotEmpty
                      ? caption
                      : LocaleKeys.articleImage.tr(),
                ),
              ),
            ),
            if ((caption ?? '').isNotEmpty) ...[
              const VerticalSpace(8),
              AppText.multiline(
                caption!,
                style: AppTextStyle.caption.copyWith(color: skin.textMuted),
              ),
            ],
          ],
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
