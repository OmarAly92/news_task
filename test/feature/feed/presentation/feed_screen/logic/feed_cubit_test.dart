import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/feed_updates_model.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_updates_params.dart';
import 'package:news_task/feature/feed/presentation/feed_screen/logic/feed_cubit.dart';
import 'package:news_task/feature/reactions/data/model/reaction_result_model.dart';
import 'package:news_task/feature/reactions/data/model/reaction_update_model.dart';

import '../../../../../helpers/cubit_recorder.dart';
import '../../../../../helpers/fixtures.dart';
import '../../../../../helpers/mocks.dart';

void main() {
  late MockFeedRepository feedRepository;
  late MockBookmarksRepository bookmarksRepository;
  late MockReactionsRepository reactionsRepository;
  late MockNetworkStatus networkStatus;
  late NetworkCubit networkCubit;
  late StreamController<ReactionUpdateModel> reactionUpdates;

  setUpAll(() {
    registerFallbackValue(const GetFeedParams());
    registerFallbackValue(const GetFeedUpdatesParams());
    registerFallbackValue(const ReactionUpdateModel());
  });

  setUp(() {
    feedRepository = MockFeedRepository();
    bookmarksRepository = MockBookmarksRepository();
    reactionsRepository = MockReactionsRepository();
    networkStatus = MockNetworkStatus();
    reactionUpdates = StreamController.broadcast();
    when(() => networkStatus.isConnected).thenAnswer((_) async => true);
    when(
      () => networkStatus.onConnectivityChanged,
    ).thenAnswer((_) => const Stream.empty());
    networkCubit = NetworkCubit(networkStatus);
    when(
      () => bookmarksRepository.watchBookmarkedIds(),
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => reactionsRepository.updates,
    ).thenAnswer((_) => reactionUpdates.stream);
    when(() => reactionsRepository.publish(any())).thenReturn(null);
    when(
      () => reactionsRepository.getPendingReactions(),
    ).thenAnswer((_) async => Result.success([]));
    when(
      () => feedRepository.getTopics(),
    ).thenAnswer((_) async => Result.success(topics));
    when(() => feedRepository.getFeedUpdates(any())).thenAnswer(
      (_) async => Result.success(
        const GlobalResponse(data: FeedUpdatesModel(deletedItems: [])),
      ),
    );
  });

  tearDown(() async {
    await reactionUpdates.close();
    await networkCubit.close();
  });

  FeedCubit build() => FeedCubit(
    feedRepository,
    bookmarksRepository,
    reactionsRepository,
    networkCubit,
  );

  void stubPage(int page, List<String> ids, {String? nextCursor}) {
    when(
      () => feedRepository.getFeed(
        any(that: predicate<GetFeedParams>((p) => (p.page ?? 1) == page)),
      ),
    ).thenAnswer(
      (_) async => Result.success(
        response(feedPage(ids, page: page, nextCursor: nextCursor)),
      ),
    );
  }

  group('getFeed', () {
    test('emits loading then success and stores page 1', () async {
      stubPage(1, ['a', 'b'], nextCursor: 'feed_2');
      final cubit = build();
      await flushMicrotasks();
      final recorder = CubitRecorder(cubit);

      await cubit.getFeed();
      await flushMicrotasks();

      expect(recorder.states, [
        const GetFeedLoadingState(),
        const GetFeedSuccessState(),
      ]);
      expect(cubit.articles.map((a) => a.id), ['a', 'b']);
      expect(cubit.hasMore, isTrue);
      expect(cubit.isStale, isFalse);
      await recorder.dispose();
    });

    test('emits failure when the repository fails', () async {
      when(
        () => feedRepository.getFeed(any()),
      ).thenAnswer((_) async => Result.failure(serverFailure()));
      final cubit = build();
      await flushMicrotasks();
      final recorder = CubitRecorder(cubit);

      await cubit.getFeed();
      await flushMicrotasks();

      expect(recorder.states, [
        const GetFeedLoadingState(),
        isA<GetFeedFailureState>(),
      ]);
      expect(cubit.articles, isEmpty);
      await recorder.dispose();
    });

    test('marks the feed stale when served from cache', () async {
      when(() => feedRepository.getFeed(any())).thenAnswer(
        (_) async => Result.success(
          GlobalResponse(
            data: feedPage(['a']),
            isCached: true,
            cachedAt: DateTime(2026, 9, 14),
          ),
        ),
      );
      final cubit = build();

      await flushMicrotasks();

      expect(cubit.isStale, isTrue);
      expect(cubit.staleSince, DateTime(2026, 9, 14));
      expect(cubit.hasMore, isFalse);
      await cubit.close();
    });
  });

  group('loadMore', () {
    test('appends the next page with the cursor and deduplicates', () async {
      stubPage(1, ['a', 'b'], nextCursor: 'feed_2');
      stubPage(2, ['b', 'c'], nextCursor: null);
      final cubit = build();
      await flushMicrotasks();
      final recorder = CubitRecorder(cubit);

      await cubit.loadMore();
      await flushMicrotasks();

      expect(cubit.articles.map((a) => a.id), ['a', 'b', 'c']);
      expect(cubit.hasMore, isFalse);
      expect(recorder.states, [
        const LoadMoreLoadingState(),
        const LoadMoreSuccessState(),
      ]);
      final params =
          verify(() => feedRepository.getFeed(captureAny())).captured.last
              as GetFeedParams;
      expect(params.cursor, 'feed_2');
      expect(params.page, 2);
      await recorder.dispose();
    });

    test('ignores calls while a page is loading or nothing is left', () async {
      stubPage(1, ['a'], nextCursor: 'feed_2');
      final completer =
          Completer<Result<GlobalResponse<FeedPageModel>, Failure>>();
      when(
        () => feedRepository.getFeed(
          any(that: predicate<GetFeedParams>((p) => p.page == 2)),
        ),
      ).thenAnswer((_) => completer.future);
      final cubit = build();
      await flushMicrotasks();

      final first = cubit.loadMore();
      final second = cubit.loadMore();
      completer.complete(Result.success(response(feedPage(['b'], page: 2))));
      await Future.wait([first, second]);
      await cubit.loadMore();

      verify(
        () => feedRepository.getFeed(
          any(that: predicate<GetFeedParams>((p) => p.page == 2)),
        ),
      ).called(1);
      expect(cubit.articles.length, 2);
      await cubit.close();
    });

    test('keeps the loaded pages and exposes the failure on error', () async {
      stubPage(1, ['a'], nextCursor: 'feed_2');
      when(
        () => feedRepository.getFeed(
          any(that: predicate<GetFeedParams>((p) => p.page == 2)),
        ),
      ).thenAnswer((_) async => Result.failure(serverFailure()));
      final cubit = build();
      await flushMicrotasks();
      final recorder = CubitRecorder(cubit);

      await cubit.loadMore();
      await flushMicrotasks();

      expect(recorder.states.last, isA<LoadMoreFailureState>());
      expect(cubit.loadMoreFailure, isNotNull);
      expect(cubit.articles.length, 1);
      expect(cubit.hasMore, isTrue);
      await recorder.dispose();
    });
  });

  group('refresh', () {
    test(
      'prepends new items, updates existing ones and drops deleted',
      () async {
        stubPage(1, ['a', 'b'], nextCursor: 'feed_2');
        final cubit = build();
        await flushMicrotasks();
        when(() => feedRepository.getFeedUpdates(any())).thenAnswer(
          (_) async => Result.success(
            const GlobalResponse(
              data: FeedUpdatesModel(newItems: ['n'], deletedItems: ['b']),
            ),
          ),
        );
        when(() => feedRepository.getFeed(any())).thenAnswer(
          (_) async => Result.success(
            response(
              FeedPageModel(
                data: [article('n'), article('a', likes: 99)],
                page: 1,
                total: 86,
                nextCursor: 'feed_2',
              ),
            ),
          ),
        );
        final recorder = CubitRecorder(cubit);

        await cubit.refresh();
        await flushMicrotasks();

        expect(cubit.articles.map((a) => a.id), ['n', 'a']);
        expect(cubit.articles[1].likes, 99);
        expect(recorder.states.single, isA<RefreshFeedSuccessState>());
        await recorder.dispose();
      },
    );
  });

  group('checkForUpdates', () {
    test('counts unseen new stories without touching the list', () async {
      stubPage(1, ['a'], nextCursor: null);
      final cubit = build();
      await flushMicrotasks();
      when(() => feedRepository.getFeedUpdates(any())).thenAnswer(
        (_) async => Result.success(
          const GlobalResponse(
            data: FeedUpdatesModel(newItems: ['a', 'x', 'y']),
          ),
        ),
      );
      final recorder = CubitRecorder(cubit);

      await cubit.checkForUpdates();
      await flushMicrotasks();

      expect(cubit.newStoriesCount, 2);
      expect(recorder.states.single, const NewStoriesAvailableState(2));
      expect(cubit.articles.length, 1);
      await recorder.dispose();
    });
  });

  group('toggleLike', () {
    setUp(() => stubPage(1, ['a'], nextCursor: null));

    test('updates optimistically then confirms with server counts', () async {
      final cubit = build();
      await flushMicrotasks();
      when(
        () => reactionsRepository.setReaction(
          articleId: 'a',
          like: true,
          expectedVersion: 1,
        ),
      ).thenAnswer(
        (_) async => Result.success(
          const ReactionResultModel(status: 'success', likes: 12, version: 2),
        ),
      );
      final recorder = CubitRecorder(cubit);

      final toggle = cubit.toggleLike(cubit.articles.first);
      expect(cubit.articles.first.isLiked, isTrue);
      expect(cubit.articles.first.likes, 11);
      await toggle;
      await flushMicrotasks();

      expect(cubit.articles.first.likes, 12);
      expect(cubit.articles.first.version, 2);
      expect(
        recorder.states.last,
        const ToggleLikeSuccessState('a', isLiked: true, wasConflict: false),
      );
      verify(() => reactionsRepository.publish(any())).called(1);
      await recorder.dispose();
    });

    test('rolls back the optimistic update when the request fails', () async {
      final cubit = build();
      await flushMicrotasks();
      when(
        () => reactionsRepository.setReaction(
          articleId: any(named: 'articleId'),
          like: any(named: 'like'),
          expectedVersion: any(named: 'expectedVersion'),
        ),
      ).thenAnswer((_) async => Result.failure(serverFailure()));
      final recorder = CubitRecorder(cubit);

      await cubit.toggleLike(cubit.articles.first);
      await flushMicrotasks();

      expect(cubit.articles.first.isLiked, isFalse);
      expect(cubit.articles.first.likes, 10);
      expect(recorder.states.last, isA<ToggleLikeFailureState>());
      await recorder.dispose();
    });

    test('reconciles to server state on conflict', () async {
      final cubit = build();
      await flushMicrotasks();
      when(
        () => reactionsRepository.setReaction(
          articleId: any(named: 'articleId'),
          like: any(named: 'like'),
          expectedVersion: any(named: 'expectedVersion'),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          ReactionResultModel.fromJson({
            'status': 'conflict',
            'serverState': {'isLiked': false, 'likes': 40, 'version': 7},
          }),
        ),
      );

      await cubit.toggleLike(cubit.articles.first);

      expect(cubit.articles.first.isLiked, isFalse);
      expect(cubit.articles.first.likes, 40);
      expect(cubit.articles.first.version, 7);
      await cubit.close();
    });

    test('ignores a second tap while the first request is in flight', () async {
      final cubit = build();
      await flushMicrotasks();
      final completer = Completer<Result<ReactionResultModel, Failure>>();
      when(
        () => reactionsRepository.setReaction(
          articleId: any(named: 'articleId'),
          like: any(named: 'like'),
          expectedVersion: any(named: 'expectedVersion'),
        ),
      ).thenAnswer((_) => completer.future);

      final first = cubit.toggleLike(cubit.articles.first);
      final second = cubit.toggleLike(cubit.articles.first);
      completer.complete(
        Result.success(const ReactionResultModel(status: 'success', likes: 11)),
      );
      await Future.wait([first, second]);

      verify(
        () => reactionsRepository.setReaction(
          articleId: any(named: 'articleId'),
          like: any(named: 'like'),
          expectedVersion: any(named: 'expectedVersion'),
        ),
      ).called(1);
      expect(cubit.articles.first.isLiked, isTrue);
      await cubit.close();
    });

    test(
      'keeps the optimistic state when the reaction is queued offline',
      () async {
        final cubit = build();
        await flushMicrotasks();
        when(
          () => reactionsRepository.setReaction(
            articleId: any(named: 'articleId'),
            like: any(named: 'like'),
            expectedVersion: any(named: 'expectedVersion'),
          ),
        ).thenAnswer(
          (_) async =>
              Result.success(const ReactionResultModel(status: 'queued')),
        );
        final recorder = CubitRecorder(cubit);

        await cubit.toggleLike(cubit.articles.first);
        await flushMicrotasks();

        expect(cubit.articles.first.isLiked, isTrue);
        expect(recorder.states.last, const ToggleLikeQueuedState('a'));
        await recorder.dispose();
      },
    );
  });
}
