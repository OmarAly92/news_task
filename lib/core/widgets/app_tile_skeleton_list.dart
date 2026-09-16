import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_shimmer.dart';
import 'package:news_task/core/widgets/shimmer_text_container.dart';

class AppTileSkeletonList extends StatelessWidget {
  const AppTileSkeletonList({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.horizontalPadding,
        vertical: 8,
      ),
      itemCount: itemCount,
      separatorBuilder: (_, _) => const VerticalSpace(10),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.skin.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusXl),
        ),
        child: Row(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: context.skin.shimmerBase,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            const HorizontalSpace(12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerTextContainer(width: 120, height: 10),
                  VerticalSpace(10),
                  ShimmerTextContainer(width: double.infinity, height: 14),
                  VerticalSpace(6),
                  ShimmerTextContainer(width: 160, height: 14),
                  VerticalSpace(10),
                  ShimmerTextContainer(width: double.infinity, height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
