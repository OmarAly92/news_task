import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/error_handling/dio_error_handler/status_code.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/failure_widgets/app_error_widget.dart';
import 'package:news_task/core/widgets/main_widgets/app_initial_state_widget.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_list.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_skeleton_list.dart';

class FeedContent extends StatelessWidget {
  const FeedContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<FeedCubit, FeedState>(
    buildWhen: (previous, current) =>
        current is GetFeedLoadingState ||
        current is GetFeedSuccessState ||
        current is GetFeedFailureState,
    builder: (context, state) {
      final cubit = context.read<FeedCubit>();
      if (state is GetFeedLoadingState) return const FeedSkeletonList();
      if (state is GetFeedFailureState) {
        if (state.failure.statusCode == StatusCode.noInternetConnection) {
          return Center(
            child: AppInitialStateWidget(
              icon: Icons.cloud_off_rounded,
              message: LocaleKeys.offlineNoData.tr(),
              onRefresh: cubit.getFeed,
            ),
          );
        }
        return Center(
          child: AppErrorWidget(
            fallbackMessage: LocaleKeys.feedLoadError.tr(),
            failure: state.failure,
            retryLabel: LocaleKeys.retry.tr(),
            onRetry: cubit.getFeed,
          ),
        );
      }
      if (cubit.isEmpty) {
        return AppInitialStateWidget(
          icon: Icons.newspaper_rounded,
          message: LocaleKeys.noStoriesYet.tr(),
          onRefresh: cubit.getFeed,
        );
      }
      return const FeedList();
    },
  );
}
