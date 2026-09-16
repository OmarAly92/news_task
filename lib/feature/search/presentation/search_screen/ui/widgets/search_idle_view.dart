import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/suggestion_chip.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

class SearchIdleView extends StatelessWidget {
  const SearchIdleView({super.key});

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final cubit = context.read<SearchCubit>();
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.horizontalPadding,
        24,
        AppConstants.horizontalPadding,
        24,
      ),
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(color: skin.card, shape: BoxShape.circle),
          child: Icon(
            Icons.manage_search_rounded,
            size: 36,
            color: skin.textMuted,
          ),
        ),
        const VerticalSpace(16),
        AppText.multiline(
          LocaleKeys.searchIdleHint.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.bodyMd.copyWith(color: skin.textSecondary),
        ),
        const VerticalSpace(32),
        BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) => current is GetTrendingSuccessState,
          builder: (context, state) {
            if (cubit.trending.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      size: 18,
                      color: skin.primaryDark,
                    ),
                    const HorizontalSpace(6),
                    AppText(
                      LocaleKeys.trendingNow.tr(),
                      style: AppTextStyle.headingSm,
                    ),
                  ],
                ),
                const VerticalSpace(12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final item in cubit.trending)
                      SuggestionChip(
                        text:
                            '${item.label ?? ''}  ·  ${item.articleCount ?? 0}',
                        onTap: () => cubit.applyQuery(
                          item.query ?? item.label ?? '',
                          topicId: item.topicId,
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
