import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/failure_widgets/app_error_widget.dart';
import 'package:news_task/core/widgets/loading_widget/app_loader.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';

class FeedLoadMoreFooter extends StatelessWidget {
  const FeedLoadMoreFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();
    return BlocBuilder<FeedCubit, FeedState>(
      buildWhen: (previous, current) =>
          current is LoadMoreLoadingState ||
          current is LoadMoreSuccessState ||
          current is LoadMoreFailureState ||
          current is RefreshFeedSuccessState,
      builder: (context, state) {
        if (state is LoadMoreFailureState) {
          return AppErrorWidget(
            fallbackMessage: LocaleKeys.loadMoreError.tr(),
            failure: state.failure,
            retryLabel: LocaleKeys.retry.tr(),
            onRetry: cubit.loadMore,
          );
        }
        if (cubit.isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: AppLoader.pagination(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
