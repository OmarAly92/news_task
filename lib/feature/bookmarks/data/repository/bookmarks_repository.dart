import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_local_data_source.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_remote_data_source.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_model.dart';
import 'package:news_task/feature/bookmarks/data/model/params/add_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/remove_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/set_bookmark_params.dart';

abstract class BookmarksRepository {
  FutureResult<List<BookmarkModel>> getBookmarks();

  Stream<List<BookmarkModel>> watchBookmarks();

  Stream<Set<String>> watchBookmarkedIds();

  FutureResult<void> addBookmark(AddBookmarkParams params);

  FutureResult<void> removeBookmark(RemoveBookmarkParams params);
}

class BookmarksRepositoryImp implements BookmarksRepository {
  BookmarksRepositoryImp(
    this._remoteDataSource,
    this._localDataSource,
    this._network,
  );

  final BookmarksRemoteDataSource _remoteDataSource;
  final BookmarksLocalDataSource _localDataSource;
  final NetworkStatus _network;

  @override
  FutureResult<List<BookmarkModel>> getBookmarks() async {
    try {
      final result = await _localDataSource.getBookmarks();
      return Result.success(result);
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Stream<List<BookmarkModel>> watchBookmarks() =>
      _localDataSource.watchBookmarks();

  @override
  Stream<Set<String>> watchBookmarkedIds() => watchBookmarks().map(
    (bookmarks) => bookmarks.map((b) => b.articleId).nonNulls.toSet(),
  );

  @override
  FutureResult<void> addBookmark(AddBookmarkParams params) async {
    try {
      await _localDataSource.addBookmark(params);
      await _pushToRemote(params.articleId, bookmarked: true);
      return Result.success(null);
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }

  @override
  FutureResult<void> removeBookmark(RemoveBookmarkParams params) async {
    try {
      await _localDataSource.removeBookmark(params);
      await _pushToRemote(params.articleId, bookmarked: false);
      return Result.success(null);
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }

  Future<void> _pushToRemote(
    String articleId, {
    required bool bookmarked,
  }) async {
    if (!await _network.isConnected) return;
    try {
      await _remoteDataSource.setBookmark(
        SetBookmarkParams(articleId: articleId, bookmarked: bookmarked),
      );
      if (bookmarked) {
        await _localDataSource.markSynced(articleId);
      } else {
        await _localDataSource.deleteBookmark(articleId);
      }
    } on Failure {
      return;
    }
  }
}
