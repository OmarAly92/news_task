import 'package:drift/drift.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/bookmarks/bookmarks_table.dart';
import 'package:news_task/core/error_handling/drift_error_handler/drift_error_handler.dart';

part 'bookmarks_dao.g.dart';

@DriftAccessor(tables: [Bookmarks])
class BookmarksDao extends DatabaseAccessor<AppDatabase>
    with _$BookmarksDaoMixin {
  BookmarksDao(super.db);

  SimpleSelectStatement<$BookmarksTable, BookmarkEntity> _active() =>
      select(bookmarks)
        ..where((t) => t.pendingRemoval.equals(false))
        ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]);

  Future<List<BookmarkEntity>> getAllBookmarks() =>
      _active().get().handleLocalFailure();

  Stream<List<BookmarkEntity>> watchAllBookmarks() =>
      _active().watch().handleLocalFailure();

  Future<BookmarkEntity?> getBookmark(String articleId) =>
      (select(bookmarks)..where((t) => t.articleId.equals(articleId)))
          .getSingleOrNull()
          .handleLocalFailure();

  Future<void> upsertBookmark(BookmarksCompanion bookmark) =>
      into(bookmarks).insertOnConflictUpdate(bookmark).handleLocalFailure();

  Future<int> markPendingRemoval(String articleId) =>
      (update(bookmarks)..where((t) => t.articleId.equals(articleId)))
          .write(
            const BookmarksCompanion(
              pendingRemoval: Value(true),
              isSynced: Value(false),
            ),
          )
          .handleLocalFailure();

  Future<int> markSynced(String articleId) =>
      (update(bookmarks)..where((t) => t.articleId.equals(articleId)))
          .write(const BookmarksCompanion(isSynced: Value(true)))
          .handleLocalFailure();

  Future<int> deleteBookmark(String articleId) => (delete(
    bookmarks,
  )..where((t) => t.articleId.equals(articleId))).go().handleLocalFailure();

  Future<List<BookmarkEntity>> getUnsyncedBookmarks() => (select(
    bookmarks,
  )..where((t) => t.isSynced.equals(false))).get().handleLocalFailure();
}
