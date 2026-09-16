import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/article/data/model/article_details_model.dart';
import 'package:news_task/feature/article/data/model/params/get_article_params.dart';
import 'package:news_task/feature/article/data/repository/article_repository.dart';
import 'package:news_task/feature/bookmarks/data/model/params/add_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/remove_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';
import 'package:news_task/feature/reactions/data/repository/reactions_repository.dart';

part 'article_details_state.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  ArticleDetailsCubit(
    this._repository,
    this._bookmarksRepository,
    this._reactionsRepository,
    this.articleId,
  ) : super(const ArticleDetailsInitialState()) {
    _bookmarksSubscription = _bookmarksRepository.watchBookmarkedIds().listen(
      _applyBookmarkedIds,
    );
    _reactionsSubscription = _reactionsRepository.updates.listen(
      _applyReactionUpdate,
    );
    getArticle();
  }

  final ArticleRepository _repository;
  final BookmarksRepository _bookmarksRepository;
  final ReactionsRepository _reactionsRepository;
  final String articleId;
  final galleryController = PageController();

  ArticleDetailsModel? article;
  List<ArticleDetailsModel> related = [];
  int galleryIndex = 0;
  Set<String> _bookmarkedIds = {};
  StreamSubscription<Set<String>>? _bookmarksSubscription;
  StreamSubscription<ReactionUpdateModel>? _reactionsSubscription;
  bool isReactionInFlight = false;
  bool isStale = false;
  DateTime? staleSince;

  bool get isBookmarked => _bookmarkedIds.contains(articleId);

  Future<void> getArticle() async {
    emit(const GetArticleLoadingState());
    final result = await _repository.getArticle(
      GetArticleParams(articleId: articleId),
    );
    ArticleDetailsModel? loaded;
    result.when(
      onSuccess: (response) {
        final data = response.data;
        if (data == null || data.isUnavailable) {
          emit(ArticleUnavailableState(reason: data?.reason));
          return;
        }
        loaded = data;
        isStale = response.isCached;
        staleSince = response.isCached ? response.cachedAt : null;
      },
      onFailure: (failure) => emit(GetArticleFailureState(failure: failure)),
    );
    if (loaded == null) return;
    article = await _withPendingReaction(
      loaded!.copyWith(isBookmarked: isBookmarked),
    );
    emit(const GetArticleSuccessState());
    getRelated();
  }

  Future<void> getRelated() async {
    final ids = article?.related ?? [];
    if (ids.isEmpty) return;
    final results = await Future.wait(
      ids.map((id) => _repository.getArticle(GetArticleParams(articleId: id))),
    );
    final loaded = <ArticleDetailsModel>[];
    for (final result in results) {
      result.when(
        onSuccess: (response) {
          final data = response.data;
          if (data != null && !data.isUnavailable) loaded.add(data);
        },
        onFailure: (_) {},
      );
    }
    related = loaded;
    emit(const GetRelatedSuccessState());
  }

  Future<void> toggleLike() async {
    final current = article;
    if (current == null || isReactionInFlight) return;
    final wasLiked = current.isLiked ?? false;
    final optimistic = current.copyWith(
      isLiked: !wasLiked,
      likes: (current.likes ?? 0) + (wasLiked ? -1 : 1),
    );
    isReactionInFlight = true;
    article = optimistic;
    emit(UpdateReactionSuccessState(optimistic.isLiked, optimistic.likes));
    final result = await _reactionsRepository.setReaction(
      articleId: articleId,
      like: !wasLiked,
      expectedVersion: current.version,
    );
    isReactionInFlight = false;
    result.when(
      onSuccess: (response) {
        if (response.isQueued) {
          emit(const ToggleLikeQueuedState());
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
        article = confirmed;
        emit(UpdateReactionSuccessState(confirmed.isLiked, confirmed.likes));
        _reactionsRepository.publish(
          ReactionUpdateModel(
            articleId: articleId,
            isLiked: confirmed.isLiked,
            likes: confirmed.likes,
            version: confirmed.version,
          ),
        );
        emit(
          ToggleLikeSuccessState(
            isLiked: confirmed.isLiked ?? false,
            wasConflict: response.isConflict,
          ),
        );
      },
      onFailure: (failure) {
        article = current;
        emit(UpdateReactionSuccessState(current.isLiked, current.likes));
        emit(ToggleLikeFailureState(failure: failure));
      },
    );
  }

  Future<ArticleDetailsModel> _withPendingReaction(
    ArticleDetailsModel data,
  ) async {
    final result = await _reactionsRepository.getPendingReactions();
    var next = data;
    result.when(
      onSuccess: (pending) {
        final match = pending
            .where((p) => p.articleId == articleId)
            .firstOrNull;
        if (match == null || match.isLike == (data.isLiked ?? false)) return;
        next = data.copyWith(
          isLiked: match.isLike,
          likes: (data.likes ?? 0) + (match.isLike ? 1 : -1),
        );
      },
      onFailure: (_) {},
    );
    return next;
  }

  void _applyReactionUpdate(ReactionUpdateModel update) {
    if (update.articleId != articleId || isReactionInFlight) return;
    final current = article;
    if (current == null) return;
    if (current.isLiked == update.isLiked && current.likes == update.likes) {
      return;
    }
    article = current.copyWith(
      isLiked: update.isLiked,
      likes: update.likes,
      version: update.version,
    );
    emit(UpdateReactionSuccessState(update.isLiked, update.likes));
  }

  Future<void> toggleBookmark() async {
    final current = article;
    if (current == null) return;
    final wasBookmarked = isBookmarked;
    _setBookmarked(!wasBookmarked);
    final result = wasBookmarked
        ? await _bookmarksRepository.removeBookmark(
            RemoveBookmarkParams(articleId: articleId),
          )
        : await _bookmarksRepository.addBookmark(
            AddBookmarkParams(
              articleId: articleId,
              title: current.title,
              summary: current.summary,
              source: current.source,
              topicId: current.topicId,
              authorName: current.author?.name,
              authorAvatar: current.author?.avatar,
              image: current.image,
              publishedAt: current.publishedAt,
            ),
          );
    result.when(
      onSuccess: (_) => emit(ToggleBookmarkSuccessState(!wasBookmarked)),
      onFailure: (failure) {
        _setBookmarked(wasBookmarked);
        emit(ToggleBookmarkFailureState(failure: failure));
      },
    );
  }

  void _applyBookmarkedIds(Set<String> ids) {
    _bookmarkedIds = ids;
    _setBookmarked(ids.contains(articleId));
  }

  void _setBookmarked(bool value) {
    if (value) {
      _bookmarkedIds = {..._bookmarkedIds, articleId};
    } else {
      _bookmarkedIds = {..._bookmarkedIds}..remove(articleId);
    }
    if (article?.isBookmarked == value) return;
    article = article?.copyWith(isBookmarked: value);
    emit(SyncBookmarkSuccessState(value));
  }

  void changeGalleryPage(int index) {
    if (index == galleryIndex) return;
    galleryIndex = index;
    emit(ChangeGalleryPageSuccessState(index));
  }

  @override
  Future<void> close() {
    _bookmarksSubscription?.cancel();
    _reactionsSubscription?.cancel();
    galleryController.dispose();
    return super.close();
  }
}
