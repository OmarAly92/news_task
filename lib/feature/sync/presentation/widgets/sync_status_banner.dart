import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/loading_widget/app_loader.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/sync/presentation/logic/sync_cubit.dart';

class SyncStatusBanner extends StatelessWidget {
  const SyncStatusBanner({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SyncCubit, SyncState>(
    buildWhen: (previous, current) =>
        current is SyncLoadingState ||
        current is SyncSuccessState ||
        current is SyncFailureState ||
        current is SyncIdleState,
    builder: (context, state) {
      final skin = context.skin;
      final (
        String? text,
        Color background,
        Color foreground,
        Widget? leading,
      ) = switch (state) {
        SyncLoadingState(:final pendingCount) => (
          LocaleKeys.syncingChanges.tr(args: ['$pendingCount']),
          skin.accentLight,
          skin.accent,
          const SizedBox.square(dimension: 14, child: AppLoader.pagination()),
        ),
        SyncSuccessState() => (
          LocaleKeys.syncedChanges.tr(),
          skin.successLight,
          skin.success,
          Icon(Icons.cloud_done_outlined, size: 16, color: skin.success),
        ),
        SyncFailureState() => (
          LocaleKeys.syncFailed.tr(),
          skin.errorLight,
          skin.error,
          Icon(Icons.sync_problem_rounded, size: 16, color: skin.error),
        ),
        _ => (null, skin.background, skin.textPrimary, null),
      };
      return AnimatedSize(
        duration: AppMotion.slow,
        curve: AppMotion.easeOut,
        alignment: Alignment.topCenter,
        child: text == null
            ? const SizedBox(width: double.infinity)
            : Semantics(
                liveRegion: true,
                child: Container(
                  width: double.infinity,
                  color: background,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalPadding,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      if (leading != null) ...[
                        leading,
                        const HorizontalSpace(8),
                      ],
                      Expanded(
                        child: AppText(
                          text,
                          style: AppTextStyle.caption.copyWith(
                            color: foreground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    },
  );
}
