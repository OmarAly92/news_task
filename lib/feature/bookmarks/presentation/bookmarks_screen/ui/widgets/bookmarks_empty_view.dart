import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';

class BookmarksEmptyView extends StatelessWidget {
  const BookmarksEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: skin.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 40,
                color: skin.primaryDark,
              ),
            ),
            const VerticalSpace(20),
            AppText.multiline(
              LocaleKeys.noBookmarksYet.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.headingSm,
            ),
            const VerticalSpace(8),
            AppText.multiline(
              LocaleKeys.noBookmarksHint.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodySm.copyWith(color: skin.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
