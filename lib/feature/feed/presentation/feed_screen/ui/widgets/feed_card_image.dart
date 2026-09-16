import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/widgets/app_badge.dart';
import 'package:news_task/core/widgets/package_widgets/app_network_image.dart';

class FeedCardImage extends StatelessWidget {
  const FeedCardImage({
    super.key,
    required this.topicName,
    required this.topicIcon,
    required this.aspectRatio,
    this.imageUrl,
  });

  final String topicName;
  final IconData topicIcon;
  final double aspectRatio;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: aspectRatio,
    child: Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl != null)
          AppNetworkImage(
            imageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        else
          ColoredBox(color: context.skin.card),
        Positioned(
          left: 12,
          top: 12,
          child: AppBadge.overlay(text: topicName, icon: topicIcon),
        ),
      ],
    ),
  );
}
