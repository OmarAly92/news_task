import 'package:flutter/material.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/package_widgets/app_shimmer.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/ui/widgets/feed_skeleton_card.dart';

class FeedSkeletonList extends StatelessWidget {
  const FeedSkeletonList({super.key});

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.horizontalPadding,
        vertical: 8,
      ),
      itemCount: 3,
      separatorBuilder: (_, _) => const VerticalSpace(16),
      itemBuilder: (context, index) => FeedSkeletonCard(isFeatured: index == 0),
    ),
  );
}
