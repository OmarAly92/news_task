import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class FeedEngagementCount extends StatelessWidget {
  const FeedEngagementCount({
    super.key,
    required this.icon,
    required this.count,
    this.color,
  });

  final IconData icon;
  final int count;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? context.skin.textMuted;
    return Semantics(
      container: true,
      label: LocaleKeys.commentsCount.tr(
        args: [FormatHelper.formatInteger(count)],
      ),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: tint),
          const HorizontalSpace(4),
          AppText(
            FormatHelper.formatInteger(count),
            style: AppTextStyle.caption.copyWith(color: tint),
          ),
        ],
      ),
    );
  }
}
