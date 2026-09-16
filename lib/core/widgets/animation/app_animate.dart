import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_task/core/app_themes/app_motion.dart';

class AppAnimate extends StatelessWidget {
  const AppAnimate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: AppMotion.slow,
      child: SlideAnimation(
        duration: AppMotion.slow,
        curve: AppMotion.easeOut,
        verticalOffset: AppMotion.fadeUpOffset,
        child: FadeInAnimation(
          duration: AppMotion.slow,
          curve: AppMotion.easeOut,
          child: child,
        ),
      ),
    );
  }
}
