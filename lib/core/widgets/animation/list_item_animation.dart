import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_task/core/app_themes/app_motion.dart';

class ListItemAnimation extends StatelessWidget {
  const ListItemAnimation({
    super.key,
    required this.index,
    required this.child,
  });

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: AppMotion.screen,
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(child: child),
      ),
    );
  }
}
