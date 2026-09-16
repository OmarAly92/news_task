import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/widgets/theme_toggle_button.dart';
import 'package:news_task/core/error_handling/dio_error_handler/status_code.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_scaffold.dart';
import 'package:news_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_app_bar_title.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_body.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<FeedCubit, FeedState>(
    listener: (context, state) {
      if (state is ToggleLikeQueuedState) {
        context.showSnackBar(LocaleKeys.reactionQueued.tr());
      }
      if (state is ToggleLikeFailureState) {
        context.showErrorSnackBar(LocaleKeys.reactionError.tr());
      }
      if (state is ToggleBookmarkSuccessState && state.isBookmarked) {
        context.showSnackBar(LocaleKeys.bookmarkSaved.tr());
      }
      if (state is ToggleBookmarkFailureState) {
        context.showErrorSnackBar(LocaleKeys.bookmarkError.tr());
      }
      if (state is RefreshFeedFailureState &&
          state.failure.statusCode != StatusCode.noInternetConnection) {
        context.showErrorSnackBar(
          state.failure.message.isEmpty
              ? LocaleKeys.feedLoadError.tr()
              : state.failure.message,
        );
      }
    },
    child: const AppScaffold(
      appBar: GlobalAppbar(
        title: FeedAppBarTitle(),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: AppConstants.horizontalPadding,
            ),
            child: ThemeToggleButton(),
          ),
        ],
      ),
      body: FeedBody(),
    ),
  );
}
