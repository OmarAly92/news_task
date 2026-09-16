import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/feed_updates_model.dart';
import 'package:news_task/feature/feed/data/model/params/cache_feed_page_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_cached_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_updates_params.dart';
import 'package:news_task/feature/feed/data/repository/feed_repository.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.dart';
import '../../../../helpers/result_matchers.dart';

void main() {
  late FeedRepositoryImp repository;
  late MockFeedRemoteDataSource remote;
  late MockFeedLocalDataSource local;
  late MockNetworkStatus network;

  const page1Params = GetFeedParams(page: 1, pageSize: 10);

  setUpAll(() {
    registerFallbackValue(page1Params);
    registerFallbackValue(const GetCachedFeedParams());
    registerFallbackValue(
      const CacheFeedPageParams(page: 1, pageSize: 10, articles: []),
    );
    registerFallbackValue(const GetFeedUpdatesParams());
  });

  setUp(() {
    remote = MockFeedRemoteDataSource();
    local = MockFeedLocalDataSource();
    network = MockNetworkStatus();
    repository = FeedRepositoryImp(remote, local, network);
    when(() => local.cacheFeedPage(any())).thenAnswer((_) async {});
    when(() => local.removeArticles(any())).thenAnswer((_) async {});
  });

  group('getFeed', () {
    test('fetches remotely and caches the page when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.getFeed(any())).thenAnswer(
        (_) async => response(feedPage(['a', 'b'], nextCursor: 'feed_2')),
      );

      final result = successValue(await repository.getFeed(page1Params));

      expect(result.isCached, isFalse);
      expect(result.data?.data?.map((a) => a.id), ['a', 'b']);
      final cached = verify(() => local.cacheFeedPage(captureAny())).captured;
      expect((cached.single as CacheFeedPageParams).articles.length, 2);
    });

    test('falls back to the cached page 1 when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final cachedAt = DateTime(2026, 9, 14, 8);
      when(() => local.getCachedFeed(any())).thenAnswer(
        (_) async => FeedPageModel(
          data: [article('a')],
          page: 1,
          total: 1,
          cachedAt: cachedAt,
        ),
      );

      final result = successValue(await repository.getFeed(page1Params));

      expect(result.isCached, isTrue);
      expect(result.cachedAt, cachedAt);
      expect(result.data?.nextCursor, isNull);
      verifyNever(() => remote.getFeed(any()));
    });

    test('falls back to cache when the remote call fails', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.getFeed(any())).thenThrow(serverFailure());
      when(() => local.getCachedFeed(any())).thenAnswer(
        (_) async => FeedPageModel(data: [article('a')], page: 1, total: 1),
      );

      final result = successValue(await repository.getFeed(page1Params));

      expect(result.isCached, isTrue);
    });

    test(
      'returns noNetwork failure when offline with an empty cache',
      () async {
        when(() => network.isConnected).thenAnswer((_) async => false);
        when(() => local.getCachedFeed(any())).thenAnswer((_) async => null);

        final failure = failureValue(await repository.getFeed(page1Params));

        expect(isNoNetwork(failure), isTrue);
      },
    );

    test('does not serve later pages from cache', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);

      final failure = failureValue(
        await repository.getFeed(
          const GetFeedParams(cursor: 'feed_2', page: 2, pageSize: 10),
        ),
      );

      expect(isNoNetwork(failure), isTrue);
      verifyNever(() => local.getCachedFeed(any()));
    });
  });

  group('getTopics', () {
    test('returns cached topics when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedTopics()).thenReturn(topics);

      final result = successValue(await repository.getTopics());

      expect(result, topics);
      verifyNever(() => remote.getTopics());
    });

    test('fails when offline and nothing is cached', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedTopics()).thenReturn([]);

      expect(isNoNetwork(failureValue(await repository.getTopics())), isTrue);
    });
  });

  group('getFeedUpdates', () {
    test('evicts deleted articles from the cache', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.getFeedUpdates(any())).thenAnswer(
        (_) async => const GlobalResponse(
          data: FeedUpdatesModel(deletedItems: ['gone'], newItems: []),
        ),
      );

      await repository.getFeedUpdates(const GetFeedUpdatesParams());

      verify(() => local.removeArticles(['gone'])).called(1);
    });

    test('returns noNetwork failure when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);

      final failure = failureValue(
        await repository.getFeedUpdates(const GetFeedUpdatesParams()),
      );

      expect(isNoNetwork(failure), isTrue);
      verifyNever(() => remote.getFeedUpdates(any()));
    });
  });
}
