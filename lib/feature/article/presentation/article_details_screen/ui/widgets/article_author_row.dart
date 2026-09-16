import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';

class ArticleAuthorRow extends StatelessWidget {
  const ArticleAuthorRow({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final article = context.read<ArticleDetailsCubit>().article;
    final author = article?.author;
    final avatar = author?.avatar;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: skin.card,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.square(
              dimension: 44,
              child: avatar == null
                  ? ColoredBox(
                      color: skin.primaryLight,
                      child: Icon(
                        Icons.person_rounded,
                        color: skin.primaryDark,
                      ),
                    )
                  : AppNetworkImage(
                      avatar,
                      fit: BoxFit.cover,
                      width: 44,
                      height: 44,
                    ),
            ),
          ),
          const HorizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  author?.name ?? '',
                  style: AppTextStyle.style14SemiBold,
                ),
                if ((author?.bio ?? '').isNotEmpty) ...[
                  const VerticalSpace(2),
                  AppText(
                    author!.bio!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.caption.copyWith(
                      color: skin.textSecondary,
                    ),
                  ),
                ],
                if (article?.updatedAt != null) ...[
                  const VerticalSpace(4),
                  AppText(
                    LocaleKeys.updatedAgo.tr(
                      args: [FormatHelper.timeAgo(article!.updatedAt)],
                    ),
                    style: AppTextStyle.caption.copyWith(color: skin.textMuted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
