import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';
import 'package:news_task/feature/reactions/presentation/widgets/like_button.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_engagement_count.dart';

class FeedCardFooter extends StatelessWidget {
  const FeedCardFooter({
    super.key,
    required this.authorName,
    required this.likes,
    required this.comments,
    required this.isLiked,
    required this.isBookmarked,
    this.authorAvatar,
    this.onBookmarkTap,
    this.onLikeTap,
  });

  final String authorName;
  final int likes;
  final int comments;
  final bool isLiked;
  final bool isBookmarked;
  final String? authorAvatar;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onLikeTap;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return Row(
      children: [
        ClipOval(
          child: SizedBox.square(
            dimension: 24,
            child: authorAvatar == null
                ? ColoredBox(
                    color: skin.primaryLight,
                    child: Icon(
                      Icons.person_rounded,
                      size: 16,
                      color: skin.primaryDark,
                    ),
                  )
                : AppNetworkImage(
                    authorAvatar!,
                    fit: BoxFit.cover,
                    width: 24,
                    height: 24,
                  ),
          ),
        ),
        const HorizontalSpace(8),
        Expanded(
          child: ExcludeSemantics(
            child: AppText(
              authorName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.caption.copyWith(color: skin.textSecondary),
            ),
          ),
        ),
        LikeButton(count: likes, isLiked: isLiked, onTap: onLikeTap),
        const HorizontalSpace(6),
        FeedEngagementCount(icon: Icons.mode_comment_outlined, count: comments),
        const HorizontalSpace(4),
        IconButton(
          onPressed: onBookmarkTap,
          tooltip:
              (isBookmarked
                      ? LocaleKeys.removeBookmark
                      : LocaleKeys.saveBookmark)
                  .tr(),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 48, height: 48),
          icon: Icon(
            isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            size: 20,
            color: isBookmarked ? skin.primaryDark : skin.textMuted,
          ),
        ),
      ],
    );
  }
}
