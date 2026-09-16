import 'package:equatable/equatable.dart';

class TrendingTopicModel extends Equatable {
  final String? label;
  final int? articleCount;
  final String? topicId;
  final String? query;

  const TrendingTopicModel({
    this.label,
    this.articleCount,
    this.topicId,
    this.query,
  });

  factory TrendingTopicModel.fromJson(Map<String, dynamic> json) =>
      TrendingTopicModel(
        label: json['label'] as String?,
        articleCount: json['articleCount'] as int?,
        topicId: json['topicId'] as String?,
        query: json['query'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'label': label,
    'articleCount': articleCount,
    'topicId': topicId,
    'query': query,
  };

  @override
  List<Object?> get props => [label, articleCount, topicId, query];
}
