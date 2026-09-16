import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';

class ArticleCollapsedTitle extends StatelessWidget {
  const ArticleCollapsedTitle({
    super.key,
    required this.title,
    required this.progress,
  });

  final String title;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final visible = progress > 0.85;
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: AppMotion.base,
        curve: AppMotion.easeOut,
        opacity: visible ? 1 : 0,
        child: AnimatedSlide(
          duration: AppMotion.base,
          curve: AppMotion.easeOut,
          offset: visible ? Offset.zero : const Offset(0, 0.25),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppText(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.style16SemiBold,
            ),
          ),
        ),
      ),
    );
  }
}
