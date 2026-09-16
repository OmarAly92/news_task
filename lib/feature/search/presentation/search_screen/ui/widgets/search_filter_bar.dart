import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/topic_icons.dart';
import 'package:news_task/core/widgets/app_bottom_sheet.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/suggestion_chip.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_filters_sheet.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is GetFiltersSuccessState ||
          current is ChangeFiltersSuccessState,
      builder: (context, state) {
        final extra =
            cubit.activeFilterCount - (cubit.selectedTopicId == null ? 0 : 1);
        return SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: 4,
            ),
            children: [
              SuggestionChip(
                icon: Icons.tune_rounded,
                text: extra == 0
                    ? LocaleKeys.filters.tr()
                    : '${LocaleKeys.filters.tr()} · $extra',
                isSelected: extra > 0,
                semanticLabel: extra == 0
                    ? LocaleKeys.openFilters.tr()
                    : LocaleKeys.activeFiltersCount.tr(args: ['$extra']),
                onTap: () => showAppSheet(
                  context: context,
                  builder: (_) => SearchFiltersSheet(cubit: cubit),
                ),
              ),
              const HorizontalSpace(8),
              SuggestionChip(
                text: LocaleKeys.allTopics.tr(),
                isSelected: cubit.selectedTopicId == null,
                onTap: () => cubit.selectTopic(null),
              ),
              for (final topic in cubit.topics) ...[
                const HorizontalSpace(8),
                SuggestionChip(
                  text: topic.name ?? '',
                  icon: TopicIcons.resolve(topic.icon),
                  isSelected: cubit.selectedTopicId == topic.id,
                  onTap: () => cubit.selectTopic(topic.id),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
