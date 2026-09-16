import 'package:equatable/equatable.dart';
import 'package:news_task/feature/feed/data/model/article_model.dart';

class FeedPageModel extends Equatable {
  final List<ArticleModel>? data;
  final int? page;
  final int? pageSize;
  final int? total;
  final String? nextCursor;
  final DateTime? cachedAt;

  const FeedPageModel({
    this.data,
    this.page,
    this.pageSize,
    this.total,
    this.nextCursor,
    this.cachedAt,
  });

  factory FeedPageModel.fromJson(Map<String, dynamic> json) => FeedPageModel(
    data: (json['data'] as List?)
        ?.map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    page: json['page'] as int?,
    pageSize: json['pageSize'] as int?,
    total: json['total'] as int?,
    nextCursor: json['nextCursor'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'page': page,
    'pageSize': pageSize,
    'total': total,
    'nextCursor': nextCursor,
  };

  @override
  List<Object?> get props => [
    data,
    page,
    pageSize,
    total,
    nextCursor,
    cachedAt,
  ];
}
