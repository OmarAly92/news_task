import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_model.dart';
import 'package:news_task/feature/bookmarks/data/model/params/add_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/remove_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/repository/bookmarks_repository.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit(this._repository) : super(const BookmarksInitialState()) {
    getBookmarks();
  }

  final BookmarksRepository _repository;

  List<BookmarkModel> bookmarks = [];
  BookmarkModel? lastRemoved;
  StreamSubscription<List<BookmarkModel>>? _subscription;

  Future<void> getBookmarks() async {
    emit(const GetBookmarksLoadingState());
    await _subscription?.cancel();
    _subscription = _repository.watchBookmarks().listen(
      (data) {
        bookmarks = data;
        emit(GetBookmarksSuccessState(data));
      },
      onError: (Object error) {
        if (error is Failure) emit(GetBookmarksFailureState(failure: error));
      },
    );
  }

  Future<void> removeBookmark(String articleId) async {
    final removed = bookmarks
        .where((b) => b.articleId == articleId)
        .firstOrNull;
    if (removed == null) return;
    lastRemoved = removed;
    final result = await _repository.removeBookmark(
      RemoveBookmarkParams(articleId: articleId),
    );
    result.when(
      onSuccess: (_) => emit(RemoveBookmarkSuccessState(articleId)),
      onFailure: (failure) =>
          emit(RemoveBookmarkFailureState(failure: failure)),
    );
  }

  Future<void> restoreLastRemoved() async {
    final bookmark = lastRemoved;
    if (bookmark?.articleId == null) return;
    lastRemoved = null;
    final result = await _repository.addBookmark(
      AddBookmarkParams(
        articleId: bookmark!.articleId!,
        title: bookmark.title,
        summary: bookmark.summary,
        source: bookmark.source,
        topicId: bookmark.topicId,
        authorName: bookmark.authorName,
        authorAvatar: bookmark.authorAvatar,
        image: bookmark.image,
        publishedAt: bookmark.publishedAt,
      ),
    );
    result.when(
      onSuccess: (_) => emit(RestoreBookmarkSuccessState(bookmark.articleId!)),
      onFailure: (failure) =>
          emit(RestoreBookmarkFailureState(failure: failure)),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
