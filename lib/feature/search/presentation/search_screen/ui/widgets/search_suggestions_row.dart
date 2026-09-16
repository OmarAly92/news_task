import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/suggestion_chip.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

class SearchSuggestionsRow extends StatelessWidget {
  const SearchSuggestionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is GetSuggestionsSuccessState ||
          current is ClearSearchSuccessState ||
          current is QueryChangedState,
      builder: (context, state) => AnimatedSize(
        duration: AppMotion.base,
        curve: AppMotion.easeOut,
        alignment: Alignment.topCenter,
        child: cubit.suggestions.isEmpty
            ? const SizedBox(width: double.infinity)
            : SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalPadding,
                    vertical: 2,
                  ),
                  itemCount: cubit.suggestions.length,
                  separatorBuilder: (_, _) => const HorizontalSpace(8),
                  itemBuilder: (context, index) => SuggestionChip(
                    icon: Icons.north_west_rounded,
                    text: cubit.suggestions[index],
                    onTap: () => cubit.applyQuery(cubit.suggestions[index]),
                  ),
                ),
              ),
      ),
    );
  }
}
