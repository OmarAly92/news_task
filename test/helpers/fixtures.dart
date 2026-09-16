import 'package:news_task/core/api/models/global_response.dart';
import 'package:news_task/core/error_handling/dio_error_handler/status_code.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/feature/feed/data/model/article_model.dart';
import 'package:news_task/feature/feed/data/model/author_model.dart';
import 'package:news_task/feature/feed/data/model/feed_page_model.dart';
import 'package:news_task/feature/feed/data/model/topic_model.dart';
import 'package:news_task/feature/search/data/model/search_page_model.dart';
import 'package:news_task/feature/search/data/model/search_result_model.dart';

ArticleModel article(
  String id, {
  int likes = 10,
  bool isLiked = false,
  bool isBookmarked = false,
  int version = 1,
  String topicId = 't_technology',
}) => ArticleModel(
  id: id,
  title: 'Title $id',
  summary: 'Summary $id',
  source: 'Source',
  author: const AuthorModel(id: 'u_1', name: 'Author'),
  topicId: topicId,
  publishedAt: DateTime.utc(2026, 9, 14, 8),
  tags: const ['tag'],
  likes: likes,
  comments: 2,
  isLiked: isLiked,
  isBookmarked: isBookmarked,
  version: version,
);

FeedPageModel feedPage(
  List<String> ids, {
  int page = 1,
  int total = 86,
  String? nextCursor,
}) => FeedPageModel(
  data: ids.map(article).toList(),
  page: page,
  pageSize: ids.length,
  total: total,
  nextCursor: nextCursor,
);

GlobalResponse<T> response<T>(T data) => GlobalResponse(data: data);

SearchPageModel searchPage(List<String> ids, {int page = 1, int total = 1}) =>
    SearchPageModel(
      query: 'q',
      data: [
        for (final id in ids)
          SearchResultModel(id: id, title: 'Title $id', summary: 'Summary $id'),
      ],
      page: page,
      pageSize: ids.length,
      total: total,
    );

const topics = [
  TopicModel(id: 't_technology', name: 'Technology', icon: 'devices'),
  TopicModel(id: 't_sports', name: 'Sports', icon: 'sports_soccer'),
];

Failure serverFailure([String message = 'boom']) =>
    ServerFailure(error: message, message: message, statusCode: 500);

Failure noNetwork() => ServerFailure.noNetwork();

bool isNoNetwork(Failure failure) =>
    failure.statusCode == StatusCode.noInternetConnection;
