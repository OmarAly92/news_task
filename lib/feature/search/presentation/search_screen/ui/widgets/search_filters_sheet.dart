import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/bottom_sheet_container.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/primary_button.dart';
import 'package:news_task/core/widgets/main_widgets/secondary_button.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/core/widgets/suggestion_chip.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

class SearchFiltersSheet extends StatelessWidget {
  const SearchFiltersSheet({super.key, required this.cubit});

  final SearchCubit cubit;

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
      initialDateRange: cubit.dateRange,
    );
    if (range != null) cubit.selectDateRange(range);
  }

  String _rangeLabel(DateTimeRange? range) {
    if (range == null) return LocaleKeys.anyDate.tr();
    final format = DateFormat.MMMd();
    return '${format.format(range.start)} – ${format.format(range.end)}';
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: cubit,
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.horizontalPadding,
          12,
          AppConstants.horizontalPadding,
          16,
        ),
        child: BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (previous, current) =>
              current is ChangeFiltersSuccessState,
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BottomSheetContainer.centered(),
              const VerticalSpace(16),
              AppText(LocaleKeys.filters.tr(), style: AppTextStyle.headingSm),
              const VerticalSpace(16),
              AppText(
                LocaleKeys.source.tr(),
                style: AppTextStyle.style14SemiBold,
              ),
              const VerticalSpace(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SuggestionChip(
                    text: LocaleKeys.allSources.tr(),
                    isSelected: cubit.selectedSource == null,
                    onTap: () => cubit.selectSource(null),
                  ),
                  for (final source in cubit.availableSources)
                    SuggestionChip(
                      text: source,
                      isSelected: cubit.selectedSource == source,
                      onTap: () => cubit.selectSource(source),
                    ),
                ],
              ),
              const VerticalSpace(16),
              AppText(
                LocaleKeys.dateRange.tr(),
                style: AppTextStyle.style14SemiBold,
              ),
              const VerticalSpace(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SuggestionChip(
                    icon: Icons.calendar_today_rounded,
                    text: _rangeLabel(cubit.dateRange),
                    isSelected: cubit.dateRange != null,
                    onTap: () => _pickDateRange(context),
                  ),
                  if (cubit.dateRange != null)
                    SuggestionChip(
                      icon: Icons.close_rounded,
                      text: LocaleKeys.anyDate.tr(),
                      onTap: () => cubit.selectDateRange(null),
                    ),
                ],
              ),
              const VerticalSpace(24),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: LocaleKeys.clearFilters.tr(),
                      onPressed: cubit.clearFilters,
                    ),
                  ),
                  const HorizontalSpace(12),
                  Expanded(
                    child: PrimaryButton(
                      text: LocaleKeys.apply.tr(),
                      onPressed: context.pop,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
