import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_highlighted_text.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.title,
    required this.summary,
    required this.source,
    required this.topicName,
    required this.query,
    this.imageUrl,
    this.publishedAt,
    this.onTap,
  });

  final String title;
  final String summary;
  final String source;
  final String topicName;
  final String query;
  final String? imageUrl;
  final DateTime? publishedAt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final radius = BorderRadius.circular(AppConstants.radiusXl);
    return Semantics(
      button: true,
      label: '$title. $source, ${FormatHelper.timeAgo(publishedAt)}',
      hint: LocaleKeys.openArticle.tr(),
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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  child: SizedBox(
                    width: 88,
                    height: 88,
                    child: imageUrl == null
                        ? ColoredBox(color: skin.card)
                        : AppNetworkImage(
                            imageUrl!,
                            fit: BoxFit.cover,
                            width: 88,
                            height: 88,
                          ),
                  ),
                ),
                const HorizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        [
                          if (topicName.isNotEmpty) topicName,
                          source,
                          FormatHelper.timeAgo(publishedAt),
                        ].join('  ·  '),
                        style: AppTextStyle.overline.copyWith(
                          color: skin.textMuted,
                        ),
                      ),
                      const VerticalSpace(4),
                      SearchHighlightedText(
                        text: title,
                        query: query,
                        maxLines: 2,
                        style: AppTextStyle.style14SemiBold,
                        highlightColor: skin.primaryDark,
                      ),
                      const VerticalSpace(4),
                      SearchHighlightedText(
                        text: summary,
                        query: query,
                        maxLines: 2,
                        style: AppTextStyle.caption.copyWith(
                          color: skin.textSecondary,
                        ),
                        highlightColor: skin.textPrimary,
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
