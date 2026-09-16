import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/app_themes/app_motion.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/bookmarks/data/model/params/add_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/remove_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:news_task/feature/feed/data/model/article_model.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_updates_params.dart';
import 'package:news_task/feature/feed/data/model/topic_model.dart';
import 'package:news_task/feature/feed/data/repository/feed_repository.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';
import 'package:news_task/feature/reactions/data/repository/reactions_repository.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit(
    this._repository,
    this._bookmarksRepository,
    this._reactionsRepository,
    this._networkCubit,
  ) : super(const FeedInitialState()) {
    scrollController.addListener(_onScroll);
    _restoredSubscription = _networkCubit.onRestored.listen(
      (_) => articles.isEmpty ? getFeed() : refresh(),
    );
    _bookmarksSubscription = _bookmarksRepository.watchBookmarkedIds().listen(
      _applyBookmarkedIds,
    );
    _reactionsSubscription = _reactionsRepository.updates.listen(
      _applyReactionUpdate,
    );
    getTopics();
    getFeed();
    _updatesTimer = Timer.periodic(_updatesInterval, (_) => checkForUpdates());
  }

  static const int pageSize = 10;
  static const Duration _updatesInterval = Duration(seconds: 30);
  static const double _loadMoreThreshold = 600;

  final FeedRepository _repository;
  final BookmarksRepository _bookmarksRepository;
  final ReactionsRepository _reactionsRepository;
  final NetworkCubit _networkCubit;
  final scrollController = ScrollController();

  List<TopicModel> topics = [];
  String? selectedTopicId;
  List<ArticleModel> articles = [];
  String? nextCursor;
  int total = 0;
  bool isLoadingMore = false;
  Failure? loadMoreFailure;
  int newStoriesCount = 0;
  DateTime? lastSyncedAt;
  bool isStale = false;
  DateTime? staleSince;
  int _currentPage = 1;

  final Set<String> _articleIds = {};
  final Set<String> _pendingDeletedIds = {};
  Set<String> _bookmarkedIds = {};
  StreamSubscription<Set<String>>? _bookmarksSubscription;
  StreamSubscription<ReactionUpdateModel>? _reactionsSubscription;
  StreamSubscription<void>? _restoredSubscription;
  final Set<String> _reactionsInFlight = {};
  Map<String, bool> _pendingReactions = {};
  Timer? _updatesTimer;
  int _requestToken = 0;

  bool get hasMore => nextCursor != null;

  bool get isEmpty => articles.isEmpty;

  TopicModel? topicById(String? id) =>
      topics.where((t) => t.id == id).firstOrNull;

  Future<void> getTopics() async {
    final result = await _repository.getTopics();
    result.when(
      onSuccess: (data) {
        topics = data;
        emit(const GetTopicsSuccessState());
      },
      onFailure: (failure) => emit(GetTopicsFailureState(failure: failure)),
    );
  }

  Future<void> getFeed() async {
    final token = ++_requestToken;
    if (topics.isEmpty) getTopics();
    emit(const GetFeedLoadingState());
    await _loadPendingReactions();
    final result = await _repository.getFeed(
      GetFeedParams(page: 1, pageSize: pageSize, topicId: selectedTopicId),
    );
    if (token != _requestToken) return;
    result.when(
      onSuccess: (response) {
        _replaceWith(response.data);
        _markFreshness(response);
        emit(const GetFeedSuccessState());
      },
      onFailure: (failure) => emit(GetFeedFailureState(failure: failure)),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || isLoadingMore || state is GetFeedLoadingState) return;
    final token = _requestToken;
    isLoadingMore = true;
    loadMoreFailure = null;
    emit(const LoadMoreLoadingState());
    final result = await _repository.getFeed(
      GetFeedParams(
        cursor: nextCursor,
        page: _currentPage + 1,
        pageSize: pageSize,
        topicId: selectedTopicId,
      ),
    );
    if (token != _requestToken) return;
    isLoadingMore = false;
    result.when(
      onSuccess: (response) {
        _currentPage++;
        _append(response.data);
        emit(const LoadMoreSuccessState());
      },
      onFailure: (failure) {
        loadMoreFailure = failure;
        emit(LoadMoreFailureState(failure: failure));
      },
    );
  }

  Future<void> refresh() async {
    final token = ++_requestToken;
    isLoadingMore = false;
    final updates = await _repository.getFeedUpdates(
      GetFeedUpdatesParams(since: lastSyncedAt),
    );
    if (token != _requestToken) return;
    updates.when(
      onSuccess: (response) {
        _pendingDeletedIds.addAll(response.data?.deletedItems ?? []);
        lastSyncedAt = response.data?.serverTime ?? DateTime.now();
      },
      onFailure: (_) {},
    );
    final result = await _repository.getFeed(
      GetFeedParams(page: 1, pageSize: pageSize, topicId: selectedTopicId),
    );
    if (token != _requestToken) return;
    result.when(
      onSuccess: (response) {
        if (articles.isEmpty || response.isCached) {
          _replaceWith(response.data);
        } else {
          _merge(response.data);
        }
        _markFreshness(response);
        newStoriesCount = 0;
        emit(RefreshFeedSuccessState(DateTime.now()));
      },
      onFailure: (failure) => emit(RefreshFeedFailureState(failure: failure)),
    );
  }

  void selectTopic(String? topicId) {
    if (topicId == selectedTopicId) return;
    selectedTopicId = topicId;
    emit(SelectTopicSuccessState(topicId));
    getFeed();
  }

  Future<void> checkForUpdates() async {
    if (state is GetFeedLoadingState || articles.isEmpty) return;
    final result = await _repository.getFeedUpdates(
      GetFeedUpdatesParams(since: lastSyncedAt),
    );
    result.when(
      onSuccess: (response) {
        final data = response.data;
        _pendingDeletedIds.addAll(data?.deletedItems ?? []);
        lastSyncedAt = data?.serverTime ?? DateTime.now();
        final fresh = (data?.newItems ?? <String>[])
            .where((id) => !_articleIds.contains(id))
            .length;
        if (fresh == 0) return;
        newStoriesCount += fresh;
        emit(NewStoriesAvailableState(newStoriesCount));
      },
      onFailure: (_) {},
    );
  }

  Future<void> showNewStories() async {
    await refresh();
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: AppMotion.screen,
      curve: AppMotion.easeOut,
    );
  }

  Future<void> toggleLike(ArticleModel article) async {
    final id = article.id;
    if (id == null || _reactionsInFlight.contains(id)) return;
    final wasLiked = article.isLiked ?? false;
    final optimistic = article.copyWith(
      isLiked: !wasLiked,
      likes: (article.likes ?? 0) + (wasLiked ? -1 : 1),
    );
    _reactionsInFlight.add(id);
    _patchArticle(id, (_) => optimistic);
    final result = await _reactionsRepository.setReaction(
      articleId: id,
      like: !wasLiked,
      expectedVersion: article.version,
    );
    _reactionsInFlight.remove(id);
    result.when(
      onSuccess: (response) {
        if (response.isQueued) {
          _pendingReactions[id] = !wasLiked;
          emit(ToggleLikeQueuedState(id));
          return;
        }
        final server = response.serverState;
        final confirmed = response.isConflict
            ? optimistic.copyWith(
                isLiked: server?.isLiked,
                likes: server?.likes,
                version: server?.version,
              )
            : optimistic.copyWith(
                likes: response.likes,
                version: response.version,
              );
        _pendingReactions.remove(id);
        _patchArticle(id, (_) => confirmed);
        _reactionsRepository.publish(
          ReactionUpdateModel(
            articleId: id,
            isLiked: confirmed.isLiked,
            likes: confirmed.likes,
            version: confirmed.version,
          ),
        );
        emit(
          ToggleLikeSuccessState(
            id,
            isLiked: confirmed.isLiked ?? false,
            wasConflict: response.isConflict,
          ),
        );
      },
      onFailure: (failure) {
        _patchArticle(id, (_) => article);
        emit(ToggleLikeFailureState(failure: failure));
      },
    );
  }

  Future<void> toggleBookmark(ArticleModel article) async {
    final id = article.id;
    if (id == null) return;
    final wasBookmarked = article.isBookmarked ?? false;
    updateArticle(article.copyWith(isBookmarked: !wasBookmarked));
    final result = wasBookmarked
        ? await _bookmarksRepository.removeBookmark(
            RemoveBookmarkParams(articleId: id),
          )
        : await _bookmarksRepository.addBookmark(
            AddBookmarkParams(
              articleId: id,
              title: article.title,
              summary: article.summary,
              source: article.source,
              topicId: article.topicId,
              authorName: article.author?.name,
              authorAvatar: article.author?.avatar,
              image: article.image,
              publishedAt: article.publishedAt,
            ),
          );
    result.when(
      onSuccess: (_) => emit(ToggleBookmarkSuccessState(id, !wasBookmarked)),
      onFailure: (failure) {
        updateArticle(article.copyWith(isBookmarked: wasBookmarked));
        emit(ToggleBookmarkFailureState(failure: failure));
      },
    );
  }

  void updateArticle(ArticleModel article) {
    final index = articles.indexWhere((a) => a.id == article.id);
    if (index == -1) return;
    articles[index] = article;
    emit(UpdateArticleSuccessState(article));
  }

  Future<void> _loadPendingReactions() async {
    final result = await _reactionsRepository.getPendingReactions();
    result.when(
      onSuccess: (pending) => _pendingReactions = {
        for (final p in pending)
          if (p.articleId != null) p.articleId!: p.isLike,
      },
      onFailure: (_) {},
    );
  }

  void _applyReactionUpdate(ReactionUpdateModel update) {
    final id = update.articleId;
    if (id == null || _reactionsInFlight.contains(id)) return;
    final index = articles.indexWhere((a) => a.id == id);
    if (index == -1) return;
    final current = articles[index];
    if (current.isLiked == update.isLiked && current.likes == update.likes) {
      return;
    }
    articles[index] = current.copyWith(
      isLiked: update.isLiked,
      likes: update.likes,
      version: update.version,
    );
    emit(UpdateArticleSuccessState(articles[index]));
  }

  void _patchArticle(String id, ArticleModel Function(ArticleModel) patch) {
    final index = articles.indexWhere((a) => a.id == id);
    if (index == -1) return;
    articles[index] = patch(articles[index]);
    emit(UpdateArticleSuccessState(articles[index]));
  }

  ArticleModel _withLocalState(ArticleModel article) {
    var next = article.copyWith(
      isBookmarked: _bookmarkedIds.contains(article.id),
    );
    final pendingLike = _pendingReactions[article.id];
    if (pendingLike != null && pendingLike != (next.isLiked ?? false)) {
      next = next.copyWith(
        isLiked: pendingLike,
        likes: (next.likes ?? 0) + (pendingLike ? 1 : -1),
      );
    }
    return next;
  }

  void _applyBookmarkedIds(Set<String> ids) {
    _bookmarkedIds = ids;
    var changed = false;
    for (var i = 0; i < articles.length; i++) {
      final article = articles[i];
      final bookmarked = ids.contains(article.id);
      if ((article.isBookmarked ?? false) == bookmarked) continue;
      articles[i] = article.copyWith(isBookmarked: bookmarked);
      changed = true;
    }
    if (changed) emit(SyncBookmarksSuccessState(ids));
  }

  void _markFreshness(GlobalResponse<FeedPageModel> response) {
    isStale = response.isCached;
    staleSince = response.isCached ? response.cachedAt : null;
  }

  void _replaceWith(FeedPageModel? page) {
    articles = [];
    _articleIds.clear();
    _currentPage = 1;
    _append(page);
  }

  void _append(FeedPageModel? page) {
    for (final article in page?.data ?? <ArticleModel>[]) {
      final id = article.id;
      if (id == null || _articleIds.contains(id)) continue;
      if (_pendingDeletedIds.contains(id)) continue;
      _articleIds.add(id);
      articles.add(_withLocalState(article));
    }
    nextCursor = page?.nextCursor;
    total = page?.total ?? total;
  }

  void _merge(FeedPageModel? page) {
    final incoming = <ArticleModel>[];
    for (final article in page?.data ?? <ArticleModel>[]) {
      final id = article.id;
      if (id == null) continue;
      final index = articles.indexWhere((a) => a.id == id);
      if (index == -1) {
        incoming.add(_withLocalState(article));
      } else {
        articles[index] = _withLocalState(article);
      }
    }
    articles.removeWhere((a) => _pendingDeletedIds.contains(a.id));
    _articleIds.removeAll(_pendingDeletedIds);
    _pendingDeletedIds.clear();
    for (final article in incoming) {
      _articleIds.add(article.id!);
    }
    articles = [...incoming, ...articles];
    total = page?.total ?? total;
  }

  void _onScroll() {
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - _loadMoreThreshold) {
      loadMore();
    }
  }

  @override
  Future<void> close() {
    _updatesTimer?.cancel();
    _bookmarksSubscription?.cancel();
    _reactionsSubscription?.cancel();
    _restoredSubscription?.cancel();
    scrollController.dispose();
    return super.close();
  }
}
