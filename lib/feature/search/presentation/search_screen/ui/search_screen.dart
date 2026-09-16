import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/utils/extensions.dart';
import 'package:news_task/core/widgets/main_widgets/app_scaffold.dart';
import 'package:news_task/core/widgets/main_widgets/global_appbar.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<SearchCubit, SearchState>(
    listener: (context, state) {
      if (state is LoadMoreResultsFailureState) {
        context.showErrorSnackBar(
          state.failure.message.isEmpty
              ? LocaleKeys.loadMoreError.tr()
              : state.failure.message,
        );
      }
    },
    child: AppScaffold(
      appBar: GlobalAppbar(titleText: LocaleKeys.search.tr()),
      body: const SearchBody(),
    ),
  );
}
