import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';
import 'package:news_task/feature/sync/data/model/params/sync_params.dart';
import 'package:news_task/feature/sync/data/model/sync_mutation_model.dart';
import 'package:news_task/feature/sync/data/model/sync_result_model.dart';
import 'package:news_task/feature/sync/data/repository/sync_repository.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.dart';
import '../../../../helpers/result_matchers.dart';

void main() {
  late SyncRepositoryImp repository;
  late MockSyncRemoteDataSource remote;
  late MockSyncLocalDataSource local;
  late MockBookmarksLocalDataSource bookmarksLocal;
  late MockReactionsRepository reactions;
  late MockNetworkStatus network;

  const reaction = SyncMutationModel(
    op: 'set_reaction',
    idempotencyKey: 'r1',
    payload: {'articleId': 'a', 'reaction': 'like'},
  );
  final pendingBookmark = BookmarkModel(
    articleId: 'b',
    savedAt: DateTime.fromMillisecondsSinceEpoch(1000),
    isSynced: false,
    pendingRemoval: false,
  );

  setUpAll(() {
    registerFallbackValue(const SyncParams(baseVersion: 0, mutations: []));
    registerFallbackValue(const ReactionUpdateModel());
  });

  setUp(() {
    remote = MockSyncRemoteDataSource();
    local = MockSyncLocalDataSource();
    bookmarksLocal = MockBookmarksLocalDataSource();
    reactions = MockReactionsRepository();
    network = MockNetworkStatus();
    repository = SyncRepositoryImp(
      remote,
      local,
      bookmarksLocal,
      reactions,
      network,
    );
    when(() => local.getBaseVersion()).thenReturn(18);
    when(() => local.saveBaseVersion(any())).thenAnswer((_) async {});
    when(() => local.removeMutation(any())).thenAnswer((_) async {});
    when(() => local.markAttempt(any())).thenAnswer((_) async {});
    when(() => bookmarksLocal.markSynced(any())).thenAnswer((_) async {});
    when(() => bookmarksLocal.deleteBookmark(any())).thenAnswer((_) async {});
    when(() => reactions.publish(any())).thenReturn(null);
  });

  void stubPending({
    List<SyncMutationModel> outbox = const [],
    List<BookmarkModel> bookmarks = const [],
  }) {
    when(() => local.getOutboxMutations()).thenAnswer((_) async => outbox);
    when(
      () => bookmarksLocal.getUnsyncedBookmarks(),
    ).thenAnswer((_) async => bookmarks);
  }

  group('sync', () {
    test('returns null without a request when nothing is pending', () async {
      stubPending();

      expect(successValue(await repository.sync()), isNull);
      verifyNever(() => remote.sync(any()));
    });

    test('fails and keeps the queue when offline', () async {
      stubPending(outbox: [reaction]);
      when(() => network.isConnected).thenAnswer((_) async => false);

      expect(isNoNetwork(failureValue(await repository.sync())), isTrue);
      verifyNever(() => remote.sync(any()));
      verifyNever(() => local.removeMutation(any()));
    });

    test('sends every pending mutation in one batch and clears them', () async {
      stubPending(outbox: [reaction], bookmarks: [pendingBookmark]);
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.sync(any())).thenAnswer(
        (_) async => const GlobalResponse(
          data: SyncResultModel(
            status: 'success',
            newVersion: 19,
            applied: ['r1', 'bookmark:b:1000'],
            conflicts: [],
          ),
        ),
      );

      final result = successValue(await repository.sync());

      expect(result?.status, 'success');
      final params =
          verify(() => remote.sync(captureAny())).captured.single as SyncParams;
      expect(params.baseVersion, 18);
      expect(params.mutations.map((m) => m.idempotencyKey), [
        'r1',
        'bookmark:b:1000',
      ]);
      verify(() => local.removeMutation('r1')).called(1);
      verify(() => bookmarksLocal.markSynced('b')).called(1);
      verify(() => local.saveBaseVersion(19)).called(1);
    });

    test(
      'drops conflicting reactions and publishes the server state',
      () async {
        stubPending(outbox: [reaction]);
        when(() => network.isConnected).thenAnswer((_) async => true);
        when(() => remote.sync(any())).thenAnswer(
          (_) async => GlobalResponse(
            data: SyncResultModel.fromJson({
              'status': 'review_required',
              'newVersion': 19,
              'applied': [],
              'conflicts': [
                {
                  'idempotencyKey': 'r1',
                  'articleId': 'a',
                  'serverLikes': 186,
                  'isLiked': true,
                },
              ],
            }),
          ),
        );

        final result = successValue(await repository.sync());

        expect(result?.conflictCount, 1);
        verify(() => local.removeMutation('r1')).called(1);
        final update =
            verify(() => reactions.publish(captureAny())).captured.single
                as ReactionUpdateModel;
        expect(update.articleId, 'a');
        expect(update.likes, 186);
        expect(update.isLiked, isTrue);
      },
    );

    test('leaves mutations queued when the request fails', () async {
      stubPending(outbox: [reaction]);
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.sync(any())).thenThrow(serverFailure());

      expect(failureValue(await repository.sync()).message, 'boom');
      verifyNever(() => local.removeMutation(any()));
      verifyNever(() => local.saveBaseVersion(any()));
    });
  });
}
