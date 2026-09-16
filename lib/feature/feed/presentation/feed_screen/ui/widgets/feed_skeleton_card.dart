import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/shimmer_text_container.dart';

class FeedSkeletonCard extends StatelessWidget {
  const FeedSkeletonCard({super.key, this.isFeatured = false});

  final bool isFeatured;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.skin.surface,
      borderRadius: BorderRadius.circular(AppConstants.radiusXl),
      border: Border.all(color: context.skin.cardBorder),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: isFeatured ? 4 / 3 : 16 / 9,
          child: ColoredBox(color: context.skin.shimmerBase),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerTextContainer(width: 120, height: 10),
              VerticalSpace(10),
              ShimmerTextContainer(width: double.infinity, height: 16),
              VerticalSpace(6),
              ShimmerTextContainer(width: 220, height: 16),
              VerticalSpace(10),
              ShimmerTextContainer(width: double.infinity, height: 12),
              VerticalSpace(14),
              ShimmerTextContainer(width: 140, height: 12),
            ],
          ),
        ),
      ],
    ),
  );
}
