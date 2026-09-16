import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/animation/tap_bounce_effect.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.count,
    required this.isLiked,
    this.onTap,
    this.iconSize = 18,
    this.textStyle,
  });

  final int count;
  final bool isLiked;
  final VoidCallback? onTap;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final tint = isLiked ? skin.error : skin.textMuted;
    return Semantics(
      container: true,
      button: true,
      toggled: isLiked,
      label: (isLiked ? LocaleKeys.unlike : LocaleKeys.like).tr(),
      value: FormatHelper.formatInteger(count),
      excludeSemantics: true,
      child: TapBounceEffect(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HorizontalSpace(6),
                AnimatedSwitcher(
                  duration: AppMotion.base,
                  switchInCurve: AppMotion.easeOut,
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: Tween<double>(begin: 0.6, end: 1).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: Icon(
                    isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    key: ValueKey(isLiked),
                    size: iconSize,
                    color: tint,
                  ),
                ),
                const HorizontalSpace(4),
                AppText(
                  FormatHelper.formatInteger(count),
                  style: (textStyle ?? AppTextStyle.caption).copyWith(
                    color: tint,
                  ),
                ),
                const HorizontalSpace(6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
