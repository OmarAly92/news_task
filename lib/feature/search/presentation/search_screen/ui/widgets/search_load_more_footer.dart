import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/widgets/loading_widget/app_loader.dart';
import 'package:news_task/feature/search/presentation/search_screen/logic/search_cubit.dart';

class SearchLoadMoreFooter extends StatelessWidget {
  const SearchLoadMoreFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is LoadMoreResultsLoadingState ||
          current is LoadMoreResultsSuccessState ||
          current is LoadMoreResultsFailureState,
      builder: (context, state) => cubit.isLoadingMore
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: AppLoader.pagination(),
            )
          : const SizedBox.shrink(),
    );
  }
}
