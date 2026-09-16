import 'package:equatable/equatable.dart';

class SearchResultModel extends Equatable {
  final String? id;
  final String? title;
  final String? summary;
  final String? source;
  final String? topicId;
  final DateTime? publishedAt;
  final String? image;

  const SearchResultModel({
    this.id,
    this.title,
    this.summary,
    this.source,
    this.topicId,
    this.publishedAt,
    this.image,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        id: json['id'] as String?,
        title: json['title'] as String?,
        summary: json['summary'] as String?,
        source: json['source'] as String?,
        topicId: json['topicId'] as String?,
        publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'source': source,
    'topicId': topicId,
    'publishedAt': publishedAt?.toUtc().toIso8601String(),
    'image': image,
  };

  @override
  List<Object?> get props => [
    id,
    title,
    summary,
    source,
    topicId,
    publishedAt,
    image,
  ];
}
