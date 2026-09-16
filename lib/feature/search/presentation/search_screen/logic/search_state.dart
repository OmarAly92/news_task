part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitialState extends SearchState {
  const SearchInitialState();
}

final class GetFiltersSuccessState extends SearchState {
  const GetFiltersSuccessState();
}

final class GetTrendingSuccessState extends SearchState {
  const GetTrendingSuccessState();
}

final class QueryChangedState extends SearchState {
  const QueryChangedState(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ClearSearchSuccessState extends SearchState {
  const ClearSearchSuccessState();
}

final class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

final class SearchSuccessState extends SearchState {
  const SearchSuccessState();
}

final class SearchFailureState extends SearchState {
  const SearchFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class LoadMoreResultsLoadingState extends SearchState {
  const LoadMoreResultsLoadingState();
}

final class LoadMoreResultsSuccessState extends SearchState {
  const LoadMoreResultsSuccessState();
}

final class LoadMoreResultsFailureState extends SearchState {
  const LoadMoreResultsFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class GetSuggestionsSuccessState extends SearchState {
  const GetSuggestionsSuccessState(this.suggestions);

  final List<String> suggestions;

  @override
  List<Object?> get props => [suggestions];
}

final class ChangeFiltersSuccessState extends SearchState {
  const ChangeFiltersSuccessState({this.topicId, this.source, this.dateRange});

  final String? topicId;
  final String? source;
  final DateTimeRange? dateRange;

  @override
  List<Object?> get props => [topicId, source, dateRange];
}
