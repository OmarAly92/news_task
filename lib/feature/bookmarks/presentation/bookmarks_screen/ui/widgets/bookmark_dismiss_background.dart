import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class BookmarkDismissBackground extends StatelessWidget {
  const BookmarkDismissBackground({super.key});

  @override
  Widget build(BuildContext context) => Container(
    alignment: AlignmentDirectional.centerEnd,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: context.skin.errorLight,
      borderRadius: BorderRadius.circular(AppConstants.radiusXl),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete_outline_rounded, color: context.skin.error),
        const HorizontalSpace(6),
        AppText(
          LocaleKeys.remove.tr(),
          style: AppTextStyle.style14SemiBold.copyWith(
            color: context.skin.error,
          ),
        ),
      ],
    ),
  );
}
