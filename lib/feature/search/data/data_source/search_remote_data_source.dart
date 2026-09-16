import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/search/data/model/params/get_suggestions_params.dart';
import 'package:news_task/feature/search/data/model/params/search_articles_params.dart';
import 'package:news_task/feature/search/data/model/search_page_model.dart';
import 'package:news_task/feature/search/data/model/suggestions_model.dart';
import 'package:news_task/feature/search/data/model/trending_model.dart';

abstract class SearchRemoteDataSource {
  Future<GlobalResponse<SearchPageModel>> searchArticles(
    SearchArticlesParams params,
  );

  Future<GlobalResponse<SuggestionsModel>> getSuggestions(
    GetSuggestionsParams params,
  );

  Future<Map<String, List<String>>> getSources();

  Future<GlobalResponse<TrendingModel>> getTrending();
}

class SearchRemoteDataSourceImp implements SearchRemoteDataSource {
  SearchRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<GlobalResponse<SearchPageModel>> searchArticles(
    SearchArticlesParams params,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.search,
      queryParameters: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: SearchPageModel.fromJson,
      withDataKey: false,
    );
  }

  @override
  Future<GlobalResponse<SuggestionsModel>> getSuggestions(
    GetSuggestionsParams params,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.suggest,
      queryParameters: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: SuggestionsModel.fromJson,
      withDataKey: false,
    );
  }

  @override
  Future<Map<String, List<String>>> getSources() async {
    final response = await _apiConsumer.get(EndPoints.sources);
    return (response.data as Map).map(
      (key, value) => MapEntry(key as String, (value as List).cast<String>()),
    );
  }

  @override
  Future<GlobalResponse<TrendingModel>> getTrending() async {
    final response = await _apiConsumer.get(EndPoints.trending);
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: TrendingModel.fromJson,
      withDataKey: false,
    );
  }
}
