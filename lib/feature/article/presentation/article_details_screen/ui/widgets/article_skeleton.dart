import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/app_pop_icon.dart';
import 'package:news_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_shimmer.dart';
import 'package:news_task/core/widgets/shimmer_text_container.dart';

class ArticleSkeleton extends StatelessWidget {
  const ArticleSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: .symmetric(horizontal: 8),
        child: GlobalAppbar.sub(
          leading: Center(
            child: Material(
              color: context.skin.surface.withValues(alpha: 0.9),
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: const AppPopIcon(),
            ),
          ),
        ),
      ),
      Expanded(
        child: AppShimmer(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: AppConstants.horizontalPaddingEdge,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusXl),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ColoredBox(color: context.skin.shimmerBase),
                ),
              ),
              const VerticalSpace(20),
              const ShimmerTextContainer(width: 140, height: 12),
              const VerticalSpace(14),
              const ShimmerTextContainer(width: double.infinity, height: 22),
              const VerticalSpace(8),
              const ShimmerTextContainer(width: 240, height: 22),
              const VerticalSpace(20),
              const ShimmerTextContainer(width: double.infinity, height: 14),
              const VerticalSpace(8),
              const ShimmerTextContainer(width: double.infinity, height: 14),
              const VerticalSpace(8),
              const ShimmerTextContainer(width: 200, height: 14),
            ],
          ),
        ),
      ),
    ],
  );
}
