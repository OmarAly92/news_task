import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';

class FeedAppBarTitle extends StatelessWidget {
  const FeedAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      AppText(
        DateFormat.MMMMEEEEd(context.locale.toString()).format(DateTime.now()),
        style: AppTextStyle.caption.copyWith(color: context.skin.textMuted),
      ),
      AppText(LocaleKeys.newsFeed.tr(), style: AppTextStyle.headingMd),
    ],
  );
}
