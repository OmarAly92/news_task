import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/article/data/data_source/article_local_data_source.dart';
import 'package:news_task/feature/article/data/data_source/article_remote_data_source.dart';
import 'package:news_task/feature/article/data/model/article_details_model.dart';
import 'package:news_task/feature/article/data/model/params/cache_article_params.dart';
import 'package:news_task/feature/article/data/model/params/get_article_params.dart';

abstract class ArticleRepository {
  FutureResult<GlobalResponse<ArticleDetailsModel>> getArticle(
    GetArticleParams params,
  );
}

class ArticleRepositoryImp implements ArticleRepository {
  ArticleRepositoryImp(
    this._remoteDataSource,
    this._localDataSource,
    this._network,
  );

  final ArticleRemoteDataSource _remoteDataSource;
  final ArticleLocalDataSource _localDataSource;
  final NetworkStatus _network;

  @override
  FutureResult<GlobalResponse<ArticleDetailsModel>> getArticle(
    GetArticleParams params,
  ) async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getArticle(params);
        final article = result.data;
        if (article != null) {
          if (article.isUnavailable) {
            await _localDataSource.removeArticle(params.articleId);
          } else {
            await _localDataSource.cacheArticle(
              CacheArticleParams(article: article),
            );
          }
        }
        return Result.success(result);
      } on Failure catch (error) {
        return _fromCache(params, error);
      }
    }
    return _fromCache(params, ServerFailure.noNetwork());
  }

  Future<Result<GlobalResponse<ArticleDetailsModel>, Failure>> _fromCache(
    GetArticleParams params,
    Failure failure,
  ) async {
    try {
      final cached = await _localDataSource.getCachedArticle(params.articleId);
      if (cached == null) return Result.failure(failure);
      final (article, cachedAt) = cached;
      return Result.success(
        GlobalResponse(data: article, isCached: true, cachedAt: cachedAt),
      );
    } on Failure catch (error) {
      return Result.failure(error);
    }
  }
}
