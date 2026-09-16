import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/app_icon_button.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/reactions/presentation/widgets/like_button.dart';

class ArticleActionBar extends StatelessWidget {
  const ArticleActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleDetailsCubit>();
    final skin = context.skin;
    return BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
      buildWhen: (previous, current) =>
          current is GetArticleSuccessState ||
          current is GetArticleLoadingState ||
          current is ArticleUnavailableState ||
          current is GetArticleFailureState ||
          current is UpdateReactionSuccessState ||
          current is SyncBookmarkSuccessState,
      builder: (context, state) {
        final article = cubit.article;
        if (article == null || state is GetArticleLoadingState) {
          return const SizedBox.shrink();
        }
        return DecoratedBox(
          decoration: BoxDecoration(
            color: skin.navBarBackground,
            border: Border(top: BorderSide(color: skin.appBarDivider)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding,
                vertical: 10,
              ),
              child: Row(
                children: [
                  LikeButton(
                    count: article.likes ?? 0,
                    isLiked: article.isLiked ?? false,
                    iconSize: 24,
                    textStyle: AppTextStyle.style14SemiBold,
                    onTap: cubit.toggleLike,
                  ),
                  const HorizontalSpace(16),
                  Semantics(
                    container: true,
                    label: LocaleKeys.commentsCount.tr(
                      args: [FormatHelper.formatInteger(article.comments ?? 0)],
                    ),
                    excludeSemantics: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.mode_comment_outlined,
                          size: 22,
                          color: skin.textMuted,
                        ),
                        const HorizontalSpace(6),
                        AppText(
                          FormatHelper.formatInteger(article.comments ?? 0),
                          style: AppTextStyle.style14SemiBold.copyWith(
                            color: skin.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Semantics(
                    button: true,
                    toggled: cubit.isBookmarked,
                    label:
                        (cubit.isBookmarked
                                ? LocaleKeys.removeBookmark
                                : LocaleKeys.saveBookmark)
                            .tr(),
                    child: AppIconButton(
                      size: 48,
                      icon: cubit.isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      iconColor: cubit.isBookmarked
                          ? skin.primaryDark
                          : skin.textSecondary,
                      onTap: cubit.toggleBookmark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
