import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/article/data/model/article_details_model.dart';
import 'package:news_task/feature/article/data/model/params/get_article_params.dart';

abstract class ArticleRemoteDataSource {
  Future<GlobalResponse<ArticleDetailsModel>> getArticle(
    GetArticleParams params,
  );
}

class ArticleRemoteDataSourceImp implements ArticleRemoteDataSource {
  ArticleRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<GlobalResponse<ArticleDetailsModel>> getArticle(
    GetArticleParams params,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.articleById(params.articleId),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: ArticleDetailsModel.fromJson,
      withDataKey: false,
    );
  }
}
