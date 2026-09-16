import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class FeedOfflineBanner extends StatelessWidget {
  const FeedOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<NetworkCubit, NetworkState>(
    buildWhen: (previous, current) =>
        current is NetworkOnlineState || current is NetworkOfflineState,
    builder: (context, state) => AnimatedSize(
      duration: AppMotion.slow,
      curve: AppMotion.easeOut,
      alignment: Alignment.topCenter,
      child: state is NetworkOfflineState
          ? Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                color: context.skin.offlineStripBackground,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 16,
                      color: context.skin.offlineStripForeground,
                    ),
                    const HorizontalSpace(8),
                    Expanded(
                      child: AppText(
                        LocaleKeys.youAreOffline.tr(),
                        style: AppTextStyle.caption.copyWith(
                          color: context.skin.offlineStripForeground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(width: double.infinity),
    ),
  );
}
