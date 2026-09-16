import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/failure_widgets/app_error_widget.dart';
import 'package:news_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_content.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_skeleton.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_stale_banner.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_unavailable_view.dart';

class ArticleDetailsBody extends StatelessWidget {
  const ArticleDetailsBody({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
        buildWhen: (previous, current) =>
            current is GetArticleLoadingState ||
            current is GetArticleSuccessState ||
            current is GetArticleFailureState ||
            current is ArticleUnavailableState,
        builder: (context, state) {
          if (state is GetArticleLoadingState) return const ArticleSkeleton();
          if (state is ArticleUnavailableState) {
            return ArticleUnavailableView(reason: state.reason);
          }
          if (state is GetArticleFailureState) {
            return Column(
              children: [
                const GlobalAppbar.sub(),
                Expanded(
                  child: Center(
                    child: AppErrorWidget(
                      fallbackMessage: LocaleKeys.articleLoadError.tr(),
                      failure: state.failure,
                      retryLabel: LocaleKeys.retry.tr(),
                      onRetry: context.read<ArticleDetailsCubit>().getArticle,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Column(
            children: [
              ArticleStaleBanner(),
              Expanded(child: ArticleContent()),
            ],
          );
        },
      );
}
