import 'package:equatable/equatable.dart';
import 'package:news_task/feature/feed/data/model/article_model.dart';

class CacheFeedPageParams extends Equatable {
  final String? topicId;
  final int page;
  final int pageSize;
  final List<ArticleModel> articles;

  const CacheFeedPageParams({
    required this.page,
    required this.pageSize,
    required this.articles,
    this.topicId,
  });

  @override
  List<Object?> get props => [topicId, page, pageSize, articles];
}
