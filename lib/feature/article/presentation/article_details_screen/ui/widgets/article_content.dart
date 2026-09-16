import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_author_row.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_content_block.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_hero_header.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_meta_row.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_related_list.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_tags.dart';

class ArticleContent extends StatelessWidget {
  const ArticleContent({super.key});

  @override
  Widget build(BuildContext context) {
    final article = context.read<ArticleDetailsCubit>().article;
    if (article == null) return const SizedBox.shrink();
    final blocks = article.body ?? [];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const ArticleHeroHeader(),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppConstants.horizontalPadding,
            20,
            AppConstants.horizontalPadding,
            0,
          ),
          sliver: SliverList.list(
            children: [
              const ArticleMetaRow(),
              const VerticalSpace(12),
              AppText.multiline(
                article.title ?? '',
                style: AppTextStyle.headingLg,
              ),
              const VerticalSpace(10),
              AppText.multiline(
                article.summary ?? '',
                style: AppTextStyle.bodyLg.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const VerticalSpace(20),
              const ArticleAuthorRow(),
              const VerticalSpace(24),
              for (final block in blocks)
                ArticleContentBlock(
                  type: block.type,
                  text: block.text,
                  url: block.url,
                  caption: block.caption,
                ),
              const ArticleTags(),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: ArticleRelatedList()),
        const SliverVerticalSpace(40),
      ],
    );
  }
}
