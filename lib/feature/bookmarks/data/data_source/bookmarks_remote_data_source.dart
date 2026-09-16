import 'package:news_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:news_task/core/api/api_request_helpers/end_points.dart';
import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/feature/bookmarks/data/model/bookmark_sync_state_model.dart';
import 'package:news_task/feature/bookmarks/data/model/params/set_bookmark_params.dart';

abstract class BookmarksRemoteDataSource {
  Future<GlobalResponse<BookmarkSyncStateModel>> setBookmark(
    SetBookmarkParams params,
  );
}

class BookmarksRemoteDataSourceImp implements BookmarksRemoteDataSource {
  BookmarksRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<GlobalResponse<BookmarkSyncStateModel>> setBookmark(
    SetBookmarkParams params,
  ) async {
    final response = await _apiConsumer.put(
      EndPoints.bookmarkById(params.articleId),
      body: params.toJson(),
    );
    return GlobalResponse.fromJson(
      response.data,
      fromJsonT: BookmarkSyncStateModel.fromJson,
      withDataKey: false,
    );
  }
}
