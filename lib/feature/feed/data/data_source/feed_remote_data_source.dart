import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/feed_updates_model.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_params.dart';
import 'package:news_task/feature/feed/data/model/params/get_feed_updates_params.dart';
import 'package:news_task/feature/feed/data/model/topic_model.dart';

abstract class FeedRemoteDataSource {
  Future<List<TopicModel>> getTopics();

  Future<GlobalResponse<FeedPageModel>> getFeed(GetFeedParams params);

  Future<GlobalResponse<FeedUpdatesModel>> getFeedUpdates(
    GetFeedUpdatesParams params,
  );
}

class FeedRemoteDataSourceImp implements FeedRemoteDataSource {
  FeedRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<List<TopicModel>> getTopics() async {
    final response = await _apiConsumer.get(EndPoints.topics);
    return (response.data as List)
        .map((e) => TopicModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<GlobalResponse<FeedPageModel>> getFeed(GetFeedParams params) async {
    final response = await _apiConsumer.get(
      EndPoints.feed,
      queryParameters: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: FeedPageModel.fromJson,
      withDataKey: false,
    );
  }

  @override
  Future<GlobalResponse<FeedUpdatesModel>> getFeedUpdates(
    GetFeedUpdatesParams params,
  ) async {
    final response = await _apiConsumer.get(
      EndPoints.feedUpdates,
      queryParameters: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: FeedUpdatesModel.fromJson,
      withDataKey: false,
    );
  }
}
