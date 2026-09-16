import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/feed/data/data_source/feed_local_data_source.dart';
import 'package:news_task/feature/feed/data/data_source/feed_remote_data_source.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/feed_updates_model.dart';
import 'package:news_task/feature/feed/data/model/params/cache_feed_page_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_cached_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_updates_params.dart';
import 'package:news_task/feature/feed/data/model/topic_model.dart';

abstract class FeedRepository {
  FutureResult<List<TopicModel>> getTopics();

  FutureResult<GlobalResponse<FeedPageModel>> getFeed(GetFeedParams params);

  FutureResult<GlobalResponse<FeedUpdatesModel>> getFeedUpdates(
    GetFeedUpdatesParams params,
  );
}

class FeedRepositoryImp implements FeedRepository {
  FeedRepositoryImp(
    this._remoteDataSource,
    this._localDataSource,
    this._network,
  );

  final FeedRemoteDataSource _remoteDataSource;
  final FeedLocalDataSource _localDataSource;
  final NetworkStatus _network;

  @override
  FutureResult<List<TopicModel>> getTopics() async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getTopics();
        await _localDataSource.cacheTopics(result);
        return Result.success(result);
      } on Failure catch (error) {
        return _topicsFromCache(error);
      }
    }
    return _topicsFromCache(ServerFailure.noNetwork());
  }

  @override
  FutureResult<GlobalResponse<FeedPageModel>> getFeed(
    GetFeedParams params,
  ) async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getFeed(params);
        final page = result.data;
        if (page != null && params.source == null) {
          await _localDataSource.cacheFeedPage(
            CacheFeedPageParams(
              topicId: params.topicId,
              page: params.page ?? 1,
              pageSize:
                  params.pageSize ?? page.pageSize ?? page.data?.length ?? 0,
              articles: page.data ?? [],
            ),
          );
        }
        return Result.success(result);
      } on Failure catch (error) {
        return _feedFromCache(params, error);
      }
    }
    return _feedFromCache(params, ServerFailure.noNetwork());
  }

  @override
  FutureResult<GlobalResponse<FeedUpdatesModel>> getFeedUpdates(
    GetFeedUpdatesParams params,
  ) async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getFeedUpdates(params);
        final deleted = result.data?.deletedItems ?? [];
        if (deleted.isNotEmpty) await _localDataSource.removeArticles(deleted);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    }
    return Result.failure(ServerFailure.noNetwork());
  }

  Future<Result<GlobalResponse<FeedPageModel>, Failure>> _feedFromCache(
    GetFeedParams params,
    Failure failure,
  ) async {
    if ((params.page ?? 1) > 1 || params.source != null) {
      return Result.failure(failure);
    }
    try {
      final cached = await _localDataSource.getCachedFeed(
        GetCachedFeedParams(topicId: params.topicId),
      );
      if (cached == null) return Result.failure(failure);
      return Result.success(
        GlobalResponse(data: cached, isCached: true, cachedAt: cached.cachedAt),
      );
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }

  Result<List<TopicModel>, Failure> _topicsFromCache(Failure failure) {
    final cached = _localDataSource.getCachedTopics();
    return cached.isEmpty ? Result.failure(failure) : Result.success(cached);
  }
}
