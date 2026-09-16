import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/bookmarks/bookmarks_dao.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_model.dart';
import 'package:news_task/feature/bookmarks/data/model/params/add_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/remove_bookmark_params.dart';

abstract class BookmarksLocalDataSource {
  Future<List<BookmarkModel>> getBookmarks();

  Stream<List<BookmarkModel>> watchBookmarks();

  Future<BookmarkModel?> getBookmark(String articleId);

  Future<void> addBookmark(AddBookmarkParams params);

  Future<void> removeBookmark(RemoveBookmarkParams params);

  Future<void> markSynced(String articleId);

  Future<void> deleteBookmark(String articleId);

  Future<List<BookmarkModel>> getUnsyncedBookmarks();
}

class BookmarksLocalDataSourceImp implements BookmarksLocalDataSource {
  BookmarksLocalDataSourceImp(this._dao);

  final BookmarksDao _dao;

  @override
  Future<List<BookmarkModel>> getBookmarks() async {
    final entities = await _dao.getAllBookmarks();
    return entities.map(BookmarkModel.fromDB).toList();
  }

  @override
  Stream<List<BookmarkModel>> watchBookmarks() => _dao.watchAllBookmarks().map(
    (entities) => entities.map(BookmarkModel.fromDB).toList(),
  );

  @override
  Future<BookmarkModel?> getBookmark(String articleId) async {
    final entity = await _dao.getBookmark(articleId);
    return entity == null ? null : BookmarkModel.fromDB(entity);
  }

  @override
  Future<void> addBookmark(AddBookmarkParams params) => _dao.upsertBookmark(
    BookmarksCompanion.insert(
      articleId: params.articleId,
      title: Value(params.title),
      summary: Value(params.summary),
      source: Value(params.source),
      topicId: Value(params.topicId),
      authorName: Value(params.authorName),
      authorAvatar: Value(params.authorAvatar),
      image: Value(params.image),
      publishedAt: Value(params.publishedAt),
      savedAt: Value(DateTime.now()),
      isSynced: const Value(false),
      pendingRemoval: const Value(false),
    ),
  );

  @override
  Future<void> removeBookmark(RemoveBookmarkParams params) =>
      _dao.markPendingRemoval(params.articleId);

  @override
  Future<void> markSynced(String articleId) => _dao.markSynced(articleId);

  @override
  Future<void> deleteBookmark(String articleId) =>
      _dao.deleteBookmark(articleId);

  @override
  Future<List<BookmarkModel>> getUnsyncedBookmarks() async {
    final entities = await _dao.getUnsyncedBookmarks();
    return entities.map(BookmarkModel.fromDB).toList();
  }
}
