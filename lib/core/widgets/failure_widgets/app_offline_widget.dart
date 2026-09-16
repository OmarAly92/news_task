import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class AppOfflineWidget extends StatelessWidget {
  const AppOfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cloud_off_rounded, size: 28, color: skin.textMuted),
        const VerticalSpace(10),
        AppText(
          LocaleKeys.offlineNoData.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.bodySm.copyWith(color: skin.textSecondary),
        ),
      ],
    );
  }
}
