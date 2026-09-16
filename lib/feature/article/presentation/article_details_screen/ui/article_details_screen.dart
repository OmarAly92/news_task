import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_scaffold.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_action_bar.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/ui/widgets/article_details_body.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocListener<ArticleDetailsCubit, ArticleDetailsState>(
        listener: (context, state) {
          if (state is ToggleLikeQueuedState) {
            context.showSnackBar(LocaleKeys.reactionQueued.tr());
          }
          if (state is ToggleLikeFailureState) {
            context.showErrorSnackBar(LocaleKeys.reactionError.tr());
          }
          if (state is ToggleBookmarkSuccessState) {
            context.showSnackBar(
              state.isBookmarked
                  ? LocaleKeys.bookmarkSaved.tr()
                  : LocaleKeys.bookmarkRemoved.tr(),
            );
          }
          if (state is ToggleBookmarkFailureState) {
            context.showErrorSnackBar(LocaleKeys.bookmarkError.tr());
          }
          if (state is GetArticleFailureState) {
            context.showErrorSnackBar(
              state.failure.message.isEmpty
                  ? LocaleKeys.articleLoadError.tr()
                  : state.failure.message,
            );
          }
        },
        child: const AppScaffold(
          body: ArticleDetailsBody(),
          bottomNavigationBar: ArticleActionBar(),
        ),
      );
}
