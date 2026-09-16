import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_ink_well.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';

class FeedNewStoriesPill extends StatelessWidget {
  const FeedNewStoriesPill({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();
    return BlocBuilder<FeedCubit, FeedState>(
      buildWhen: (previous, current) =>
          current is NewStoriesAvailableState ||
          current is RefreshFeedSuccessState ||
          current is GetFeedLoadingState,
      builder: (context, state) {
        final visible = cubit.newStoriesCount > 0;
        final radius = BorderRadius.circular(AppConstants.radiusPill);
        return AnimatedSlide(
          duration: AppMotion.slow,
          curve: AppMotion.easeOut,
          offset: visible ? Offset.zero : const Offset(0, -2),
          child: AnimatedOpacity(
            duration: AppMotion.base,
            opacity: visible ? 1 : 0,
            child: IgnorePointer(
              ignoring: !visible,
              child: Semantics(
                button: true,
                liveRegion: visible,
                hidden: !visible,
                label: LocaleKeys.newStoriesAvailable.tr(),
                excludeSemantics: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Material(
                    color: context.skin.inverseSurface,
                    borderRadius: radius,
                    elevation: 6,
                    shadowColor: context.skin.shadow,
                    child: AppInkWell(
                      borderRadius: radius,
                      onTap: cubit.showNewStories,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              size: 16,
                              color: context.skin.onInverseSurface,
                            ),
                            const HorizontalSpace(8),
                            AppText(
                              LocaleKeys.newStoriesAvailable.tr(),
                              style: AppTextStyle.style14SemiBold.copyWith(
                                color: context.skin.onInverseSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
