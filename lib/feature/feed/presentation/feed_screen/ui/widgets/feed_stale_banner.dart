import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/failure_widgets/app_stale_banner.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';

class FeedStaleBanner extends StatelessWidget {
  const FeedStaleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();
    return BlocBuilder<FeedCubit, FeedState>(
      buildWhen: (previous, current) =>
          current is GetFeedSuccessState ||
          current is GetFeedLoadingState ||
          current is GetFeedFailureState ||
          current is RefreshFeedSuccessState,
      builder: (context, state) => AppStaleBanner(
        message: cubit.isStale
            ? LocaleKeys.showingCachedFrom.tr(
                args: [FormatHelper.timeAgo(cubit.staleSince).toLowerCase()],
              )
            : null,
        onRetry: cubit.isStale ? cubit.refresh : null,
      ),
    );
  }
}
