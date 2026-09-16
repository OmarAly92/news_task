import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/error_handling/dio_error_handler/status_code.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';
import 'package:news_task/core/widgets/failure_widgets/app_error_widget.dart';
import 'package:news_task/core/widgets/app_tile_skeleton_list.dart';
import 'package:news_task/core/widgets/main_widgets/app_initial_state_widget.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_empty_view.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_idle_view.dart';
import 'package:news_task/feature/search/presentation/search_screen/ui/widgets/search_results_list.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchCubit, SearchState>(
    buildWhen: (previous, current) =>
        current is SearchLoadingState ||
        current is SearchSuccessState ||
        current is SearchFailureState ||
        current is ClearSearchSuccessState,
    builder: (context, state) {
      final cubit = context.read<SearchCubit>();
      if (!cubit.hasQuery) return const SearchIdleView();
      if (state is SearchLoadingState) return const AppTileSkeletonList();
      if (state is SearchFailureState) {
        if (state.failure.statusCode == StatusCode.noInternetConnection) {
          return AppInitialStateWidget(
            icon: Icons.cloud_off_rounded,
            message: LocaleKeys.offlineNoData.tr(),
            onRefresh: cubit.search,
          );
        }
        return Center(
          child: AppErrorWidget(
            fallbackMessage: LocaleKeys.searchLoadError.tr(),
            failure: state.failure,
            retryLabel: LocaleKeys.retry.tr(),
            onRetry: cubit.search,
          ),
        );
      }
      if (state is SearchSuccessState && cubit.results.isEmpty) {
        return SearchEmptyView(query: cubit.query);
      }
      if (cubit.results.isEmpty) return const AppTileSkeletonList();
      return const SearchResultsList();
    },
  );
}
