import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/core/utils/debouncer.dart';
import 'package:news_task/feature/feed/data/model/topic_model.dart';
import 'package:news_task/feature/feed/data/repository/feed_repository.dart';
import 'package:news_task/feature/search/data/model/params/get_suggestions_params.dart';
import 'package:news_task/feature/search/data/model/params/search_articles_params.dart';
import 'package:news_task/feature/search/data/model/search_page_model.dart';
import 'package:news_task/feature/search/data/model/search_result_model.dart';
import 'package:news_task/feature/search/data/model/trending_topic_model.dart';
import 'package:news_task/feature/search/data/repository/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repository, this._feedRepository)
    : super(const SearchInitialState()) {
    scrollController.addListener(_onScroll);
    getFilters();
    getTrending();
  }

  static const int pageSize = 10;
  static const int minQueryLength = 2;
  static const Duration debounceDuration = Duration(milliseconds: 400);
  static const double _loadMoreThreshold = 400;

  final SearchRepository _repository;
  final FeedRepository _feedRepository;
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final scrollController = ScrollController();
  final _debouncer = Debouncer(delay: debounceDuration);

  String query = '';
  List<SearchResultModel> results = [];
  List<String> suggestions = [];
  List<TrendingTopicModel> trending = [];
  List<TopicModel> topics = [];
  Map<String, List<String>> sourcesByTopic = {};
  String? selectedTopicId;
  String? selectedSource;
  DateTimeRange? dateRange;
  int page = 1;
  int total = 0;
  bool isLoadingMore = false;

  int _requestToken = 0;

  bool get hasQuery => query.length >= minQueryLength;

  bool get hasMore => results.length < total;

  int get activeFilterCount =>
      (selectedTopicId == null ? 0 : 1) +
      (selectedSource == null ? 0 : 1) +
      (dateRange == null ? 0 : 1);

  List<String> get availableSources => selectedTopicId == null
      ? sourcesByTopic.values.expand((s) => s).toSet().toList()
      : sourcesByTopic[selectedTopicId] ?? [];

  TopicModel? topicById(String? id) =>
      topics.where((t) => t.id == id).firstOrNull;

  Future<void> getFilters() async {
    final topicsResult = await _feedRepository.getTopics();
    topicsResult.when(onSuccess: (data) => topics = data, onFailure: (_) {});
    final sourcesResult = await _repository.getSources();
    sourcesResult.when(
      onSuccess: (data) => sourcesByTopic = data,
      onFailure: (_) {},
    );
    emit(const GetFiltersSuccessState());
  }

  Future<void> getTrending() async {
    final result = await _repository.getTrending();
    result.when(
      onSuccess: (response) {
        trending = response.data?.topics ?? [];
        emit(const GetTrendingSuccessState());
      },
      onFailure: (_) {},
    );
  }

  void onQueryChanged(String text) {
    final next = text.trim();
    if (next == query) return;
    query = next;
    emit(QueryChangedState(query));
    if (!hasQuery) {
      _debouncer.cancel();
      _requestToken++;
      results = [];
      suggestions = [];
      emit(const ClearSearchSuccessState());
      return;
    }
    _debouncer.run(() {
      search();
      getSuggestions();
    });
  }

  Future<void> search() async {
    if (!hasQuery) return;
    final token = ++_requestToken;
    page = 1;
    isLoadingMore = false;
    emit(const SearchLoadingState());
    final result = await _repository.searchArticles(_params(page));
    if (token != _requestToken) return;
    result.when(
      onSuccess: (response) {
        _replaceWith(response.data);
        emit(const SearchSuccessState());
      },
      onFailure: (failure) => emit(SearchFailureState(failure: failure)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore || state is SearchLoadingState) return;
    final token = _requestToken;
    isLoadingMore = true;
    emit(const LoadMoreResultsLoadingState());
    final result = await _repository.searchArticles(_params(page + 1));
    if (token != _requestToken) return;
    isLoadingMore = false;
    result.when(
      onSuccess: (response) {
        page++;
        _append(response.data);
        emit(const LoadMoreResultsSuccessState());
      },
      onFailure: (failure) =>
          emit(LoadMoreResultsFailureState(failure: failure)),
    );
  }

  Future<void> getSuggestions() async {
    if (!hasQuery) return;
    final token = _requestToken;
    final result = await _repository.getSuggestions(
      GetSuggestionsParams(query: query),
    );
    if (token != _requestToken) return;
    result.when(
      onSuccess: (response) {
        suggestions = (response.data?.suggestions ?? [])
            .where((s) => s.toLowerCase() != query.toLowerCase())
            .toList();
        emit(GetSuggestionsSuccessState(suggestions));
      },
      onFailure: (_) {},
    );
  }

  void applyQuery(String text, {String? topicId}) {
    _debouncer.cancel();
    searchController.text = text;
    searchController.selection = TextSelection.collapsed(offset: text.length);
    query = text.trim();
    suggestions = [];
    if (topicId != null) {
      selectedTopicId = topicId;
      selectedSource = null;
      emit(_filtersState);
    }
    emit(QueryChangedState(query));
    search();
  }

  void clearQuery() {
    searchController.clear();
    onQueryChanged('');
    searchFocusNode.requestFocus();
  }

  void selectTopic(String? topicId) {
    if (topicId == selectedTopicId) return;
    selectedTopicId = topicId;
    if (!availableSources.contains(selectedSource)) selectedSource = null;
    _filtersChanged();
  }

  void selectSource(String? source) {
    if (source == selectedSource) return;
    selectedSource = source;
    _filtersChanged();
  }

  void selectDateRange(DateTimeRange? range) {
    if (range == dateRange) return;
    dateRange = range;
    _filtersChanged();
  }

  void clearFilters() {
    if (activeFilterCount == 0) return;
    selectedTopicId = null;
    selectedSource = null;
    dateRange = null;
    _filtersChanged();
  }

  void _filtersChanged() {
    emit(_filtersState);
    if (hasQuery) search();
  }

  ChangeFiltersSuccessState get _filtersState => ChangeFiltersSuccessState(
    topicId: selectedTopicId,
    source: selectedSource,
    dateRange: dateRange,
  );

  SearchArticlesParams _params(int page) => SearchArticlesParams(
    query: query,
    page: page,
    pageSize: pageSize,
    topicId: selectedTopicId,
    source: selectedSource,
    from: dateRange?.start,
    to: dateRange?.end.add(const Duration(days: 1)),
  );

  void _replaceWith(SearchPageModel? data) {
    results = [];
    total = 0;
    _append(data);
  }

  void _append(SearchPageModel? data) {
    final seen = results.map((r) => r.id).toSet();
    results = [
      ...results,
      ...?data?.data?.where((r) => r.id != null && seen.add(r.id)),
    ];
    total = data?.total ?? total;
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      loadMore();
    }
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    searchController.dispose();
    searchFocusNode.dispose();
    scrollController.dispose();
    return super.close();
  }
}
