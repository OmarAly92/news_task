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
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_card_footer.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_card_image.dart';

class FeedArticleCard extends StatelessWidget {
  const FeedArticleCard({
    super.key,
    required this.title,
    required this.summary,
    required this.source,
    required this.topicName,
    required this.topicIcon,
    required this.authorName,
    required this.likes,
    required this.comments,
    required this.isLiked,
    required this.isBookmarked,
    this.imageUrl,
    this.authorAvatar,
    this.publishedAt,
    this.isFeatured = false,
    this.onTap,
    this.onBookmarkTap,
    this.onLikeTap,
  });

  final String title;
  final String summary;
  final String source;
  final String topicName;
  final IconData topicIcon;
  final String authorName;
  final int likes;
  final int comments;
  final bool isLiked;
  final bool isBookmarked;
  final String? imageUrl;
  final String? authorAvatar;
  final DateTime? publishedAt;
  final bool isFeatured;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onLikeTap;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final radius = BorderRadius.circular(AppConstants.radiusXl);
    return Semantics(
      button: true,
      label:
          '$title. $source, $topicName, $authorName, ${FormatHelper.timeAgo(publishedAt)}',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: FeedCardImage(
                  imageUrl: imageUrl,
                  topicName: topicName,
                  topicIcon: topicIcon,
                  aspectRatio: isFeatured ? 4 / 3 : 16 / 9,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExcludeSemantics(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            '$source  ·  ${FormatHelper.timeAgo(publishedAt)}',
                            style: AppTextStyle.overline.copyWith(
                              color: skin.textMuted,
                            ),
                          ),
                          const VerticalSpace(6),
                          AppText(
                            title,
                            maxLines: isFeatured ? 3 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: isFeatured
                                ? AppTextStyle.headingMd
                                : AppTextStyle.headingSm,
                          ),
                          const VerticalSpace(6),
                          AppText(
                            summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bodySm.copyWith(
                              color: skin.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpace(12),
                    FeedCardFooter(
                      authorName: authorName,
                      authorAvatar: authorAvatar,
                      likes: likes,
                      comments: comments,
                      isLiked: isLiked,
                      isBookmarked: isBookmarked,
                      onBookmarkTap: onBookmarkTap,
                      onLikeTap: onLikeTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
