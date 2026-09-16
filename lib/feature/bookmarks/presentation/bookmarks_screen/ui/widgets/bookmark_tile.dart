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

class BookmarkTile extends StatelessWidget {
  const BookmarkTile({
    super.key,
    required this.title,
    required this.summary,
    required this.source,
    required this.isSynced,
    this.imageUrl,
    this.savedAt,
    this.onTap,
    this.onRemove,
  });

  final String title;
  final String summary;
  final String source;
  final bool isSynced;
  final String? imageUrl;
  final DateTime? savedAt;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final radius = BorderRadius.circular(AppConstants.radiusXl);
    return Semantics(
      button: true,
      label: '$title. $source, ${FormatHelper.timeAgo(savedAt)}',
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
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              '$source  ·  ${FormatHelper.timeAgo(savedAt)}',
                              style: AppTextStyle.overline.copyWith(
                                color: skin.textMuted,
                              ),
                            ),
                          ),
                          if (!isSynced)
                            Tooltip(
                              message: LocaleKeys.pendingSync.tr(),
                              child: Icon(
                                semanticLabel: LocaleKeys.pendingSync.tr(),
                                Icons.cloud_upload_outlined,
                                size: 14,
                                color: skin.textMuted,
                              ),
                            ),
                        ],
                      ),
                      const VerticalSpace(4),
                      AppText(
                        title,
                        maxLines: 2,
                        style: AppTextStyle.style14SemiBold,
                      ),
                      const VerticalSpace(4),
                      AppText(
                        summary,
                        maxLines: 2,
                        style: AppTextStyle.caption.copyWith(
                          color: skin.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const HorizontalSpace(4),
                IconButton(
                  onPressed: onRemove,
                  tooltip: LocaleKeys.removeBookmark.tr(),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 48,
                    height: 48,
                  ),
                  icon: Icon(
                    Icons.bookmark_rounded,
                    size: 20,
                    color: skin.primaryDark,
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
