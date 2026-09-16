import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/core/database/tables/bookmarks/bookmarks_dao.dart';
import 'package:news_task/feature/bookmarks/data/data_source/bookmarks_local_data_source.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_sync_state_model.dart';
import 'package:news_task/feature/bookmarks/data/model/params/add_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/remove_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/model/params/set_bookmark_params.dart';
import 'package:news_task/feature/bookmarks/data/repository/bookmarks_repository.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.dart';
import '../../../../helpers/result_matchers.dart';

void main() {
  late AppDatabase db;
  late BookmarksRepositoryImp repository;
  late MockBookmarksRemoteDataSource remote;
  late MockNetworkStatus network;

  const add = AddBookmarkParams(articleId: 'a_1', title: 'Story', source: 'S');

  setUpAll(() {
    registerFallbackValue(
      const SetBookmarkParams(articleId: 'x', bookmarked: true),
    );
  });

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    remote = MockBookmarksRemoteDataSource();
    network = MockNetworkStatus();
    repository = BookmarksRepositoryImp(
      remote,
      BookmarksLocalDataSourceImp(BookmarksDao(db)),
      network,
    );
    when(() => remote.setBookmark(any())).thenAnswer(
      (_) async =>
          const GlobalResponse(data: BookmarkSyncStateModel(bookmarked: true)),
    );
  });

  tearDown(() => db.close());

  group('addBookmark', () {
    test('persists locally and marks synced when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);

      successValue(await repository.addBookmark(add));
      final bookmarks = successValue(await repository.getBookmarks());

      expect(bookmarks.single.articleId, 'a_1');
      expect(bookmarks.single.title, 'Story');
      expect(bookmarks.single.isSynced, isTrue);
      verify(() => remote.setBookmark(any())).called(1);
    });

    test('persists locally as unsynced when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);

      successValue(await repository.addBookmark(add));
      final bookmarks = successValue(await repository.getBookmarks());

      expect(bookmarks.single.isSynced, isFalse);
      verifyNever(() => remote.setBookmark(any()));
    });

    test('keeps the bookmark when the remote push fails', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.setBookmark(any())).thenThrow(serverFailure());

      successValue(await repository.addBookmark(add));
      final bookmarks = successValue(await repository.getBookmarks());

      expect(bookmarks.single.isSynced, isFalse);
    });
  });

  group('removeBookmark', () {
    test('hides the bookmark immediately and deletes it when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      await repository.addBookmark(add);

      successValue(
        await repository.removeBookmark(
          const RemoveBookmarkParams(articleId: 'a_1'),
        ),
      );

      expect(successValue(await repository.getBookmarks()), isEmpty);
    });

    test('marks the bookmark for removal when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      await repository.addBookmark(add);

      await repository.removeBookmark(
        const RemoveBookmarkParams(articleId: 'a_1'),
      );

      expect(successValue(await repository.getBookmarks()), isEmpty);
      final pending = await BookmarksDao(db).getUnsyncedBookmarks();
      expect(pending.single.pendingRemoval, isTrue);
    });
  });

  group('watchBookmarkedIds', () {
    test('emits the id set as bookmarks change', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);

      final expectation = expectLater(
        repository.watchBookmarkedIds(),
        emitsInOrder([
          emitsThrough({'a_1'}),
          emitsThrough(<String>{}),
        ]),
      );
      await repository.addBookmark(add);
      await repository.removeBookmark(
        const RemoveBookmarkParams(articleId: 'a_1'),
      );

      await expectation;
    });
  });
}
