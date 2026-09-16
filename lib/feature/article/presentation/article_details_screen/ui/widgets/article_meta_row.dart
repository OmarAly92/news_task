import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/format/format_helper.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/app_badge.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/article/presentation/article_details_screen/logic/article_details_cubit.dart';

class ArticleMetaRow extends StatelessWidget {
  const ArticleMetaRow({super.key});

  @override
  Widget build(BuildContext context) {
    final article = context.read<ArticleDetailsCubit>().article;
    final muted = AppTextStyle.overline.copyWith(color: context.skin.textMuted);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: [
        AppBadge(text: article?.source ?? ''),
        AppText(FormatHelper.timeAgo(article?.publishedAt), style: muted),
        if (article?.readTimeMinutes != null) ...[
          AppText('·', style: muted),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 14,
                color: context.skin.textMuted,
              ),
              const HorizontalSpace(4),
              AppText(
                LocaleKeys.minRead.tr(args: ['${article!.readTimeMinutes}']),
                style: muted,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
