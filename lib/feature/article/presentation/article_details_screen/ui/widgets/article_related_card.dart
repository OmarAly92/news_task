import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';

class ArticleRelatedCard extends StatelessWidget {
  const ArticleRelatedCard({
    super.key,
    required this.title,
    required this.source,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String source;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final radius = BorderRadius.circular(AppConstants.radiusXl);
    return Semantics(
      button: true,
      label: '$title. $source',
      hint: LocaleKeys.openArticle.tr(),
      child: SizedBox(
        width: 200,
        child: Material(
          color: skin.surface,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: skin.cardBorder),
          ),
          child: AppInkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: imageUrl == null
                      ? ColoredBox(color: skin.card)
                      : AppNetworkImage(
                          imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        source,
                        style: AppTextStyle.overline.copyWith(
                          color: skin.textMuted,
                        ),
                      ),
                      const VerticalSpace(4),
                      AppText(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.style14SemiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
