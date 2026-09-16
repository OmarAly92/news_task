import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/reactions/data/model/params/set_reaction_params.dart';
import 'package:news_task/feature/reactions/data/model/reaction_result_model.dart';

abstract class ReactionsRemoteDataSource {
  Future<GlobalResponse<ReactionResultModel>> setReaction(
    SetReactionParams params,
  );
}

class ReactionsRemoteDataSourceImp implements ReactionsRemoteDataSource {
  ReactionsRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<GlobalResponse<ReactionResultModel>> setReaction(
    SetReactionParams params,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.articleReactions(params.articleId),
      body: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: ReactionResultModel.fromJson,
      withDataKey: false,
    );
  }
}
