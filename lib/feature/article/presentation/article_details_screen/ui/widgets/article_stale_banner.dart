import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/failure_widgets/app_stale_banner.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';

class ArticleStaleBanner extends StatelessWidget {
  const ArticleStaleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleDetailsCubit>();
    return BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
      buildWhen: (previous, current) => current is GetArticleSuccessState,
      builder: (context, state) {
        if (!cubit.isStale) return const SizedBox.shrink();
        return SafeArea(
          bottom: false,
          child: AppStaleBanner(
            message: LocaleKeys.showingCachedArticle.tr(
              args: [FormatHelper.timeAgo(cubit.staleSince).toLowerCase()],
            ),
            onRetry: cubit.getArticle,
          ),
        );
      },
    );
  }
}
