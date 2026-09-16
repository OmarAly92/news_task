import 'package:equatable/equatable.dart';
import 'package:news_task/feature/article/data/model/article_details_model.dart';

class CacheArticleParams extends Equatable {
  final ArticleDetailsModel article;

  const CacheArticleParams({required this.article});

  @override
  List<Object?> get props => [article];
}
