import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/network_status.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/search/data/data_source/search_remote_data_source.dart';
import 'package:news_task/feature/search/data/model/params/get_suggestions_params.dart';
import 'package:news_task/feature/search/data/model/params/search_articles_params.dart';
import 'package:news_task/feature/search/data/model/search_page_model.dart';
import 'package:news_task/feature/search/data/model/suggestions_model.dart';
import 'package:news_task/feature/search/data/model/trending_model.dart';

abstract class SearchRepository {
  FutureResult<GlobalResponse<SearchPageModel>> searchArticles(
    SearchArticlesParams params,
  );

  FutureResult<GlobalResponse<SuggestionsModel>> getSuggestions(
    GetSuggestionsParams params,
  );

  FutureResult<Map<String, List<String>>> getSources();

  FutureResult<GlobalResponse<TrendingModel>> getTrending();
}

class SearchRepositoryImp implements SearchRepository {
  SearchRepositoryImp(this._remoteDataSource, this._network);

  final SearchRemoteDataSource _remoteDataSource;
  final NetworkStatus _network;

  @override
  FutureResult<GlobalResponse<SearchPageModel>> searchArticles(
    SearchArticlesParams params,
  ) async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.searchArticles(params);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    }
    return Result.failure(ServerFailure.noNetwork());
  }

  @override
  FutureResult<GlobalResponse<SuggestionsModel>> getSuggestions(
    GetSuggestionsParams params,
  ) async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getSuggestions(params);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    }
    return Result.failure(ServerFailure.noNetwork());
  }

  @override
  FutureResult<Map<String, List<String>>> getSources() async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getSources();
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    }
    return Result.failure(ServerFailure.noNetwork());
  }

  @override
  FutureResult<GlobalResponse<TrendingModel>> getTrending() async {
    if (await _network.isConnected) {
      try {
        final result = await _remoteDataSource.getTrending();
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    }
    return Result.failure(ServerFailure.noNetwork());
  }
}
