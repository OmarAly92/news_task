import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/app_themes/colors/skin_scope.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/app_constants.dart';
import 'package:news_task/core/widgets/main_widgets/app_text_field.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.horizontalPadding,
        4,
        AppConstants.horizontalPadding,
        8,
      ),
      child: BlocBuilder<SearchCubit, SearchState>(
        buildWhen: (previous, current) => current is QueryChangedState,
        builder: (context, state) => AppTextField(
          controller: cubit.searchController,
          focusNode: cubit.searchFocusNode,
          hint: LocaleKeys.searchHint.tr(),
          fillColor: context.skin.searchFieldFill,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          onChanged: cubit.onQueryChanged,
          onFieldSubmitted: cubit.applyQuery,
          prefixIcon: Icon(Icons.search_rounded, color: context.skin.textMuted),
          suffixIcon: cubit.query.isEmpty
              ? null
              : IconButton(
                  onPressed: cubit.clearQuery,
                  tooltip: LocaleKeys.clearSearch.tr(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: context.skin.textMuted,
                  ),
                ),
        ),
      ),
    );
  }
}
