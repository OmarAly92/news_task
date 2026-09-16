import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/sync/data/model/params/sync_params.dart';
import 'package:news_task/feature/sync/data/model/sync_result_model.dart';

abstract class SyncRemoteDataSource {
  Future<GlobalResponse<SyncResultModel>> sync(SyncParams params);
}

class SyncRemoteDataSourceImp implements SyncRemoteDataSource {
  SyncRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<GlobalResponse<SyncResultModel>> sync(SyncParams params) async {
    final response = await _apiConsumer.post(
      EndPoints.sync,
      body: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: SyncResultModel.fromJson,
      withDataKey: false,
    );
  }
}
