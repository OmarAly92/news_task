import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/app_themes/text_style/app_text_style.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/main_widgets/app_text.dart';
import 'package:news_task/core/widgets/main_widgets/secondary_button.dart';
import 'package:news_task/core/widgets/main_widgets/space_widgets.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

class SearchEmptyView extends StatelessWidget {
  const SearchEmptyView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final skin = context.skin;
    final cubit = context.read<SearchCubit>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: skin.textMuted),
            const VerticalSpace(16),
            AppText.multiline(
              LocaleKeys.noResultsFor.tr(args: [query]),
              textAlign: TextAlign.center,
              style: AppTextStyle.headingSm,
            ),
            const VerticalSpace(8),
            AppText.multiline(
              LocaleKeys.tryDifferentKeywords.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodySm.copyWith(color: skin.textSecondary),
            ),
            if (cubit.activeFilterCount > 0) ...[
              const VerticalSpace(20),
              SecondaryButton(
                text: LocaleKeys.clearFilters.tr(),
                onPressed: cubit.clearFilters,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
