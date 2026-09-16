import 'package:equatable/equatable.dart';

class AddBookmarkParams extends Equatable {
  final String articleId;
  final String? title;
  final String? summary;
  final String? source;
  final String? topicId;
  final String? authorName;
  final String? authorAvatar;
  final String? image;
  final DateTime? publishedAt;

  const AddBookmarkParams({
    required this.articleId,
    this.title,
    this.summary,
    this.source,
    this.topicId,
    this.authorName,
    this.authorAvatar,
    this.image,
    this.publishedAt,
  });

  @override
  List<Object?> get props => [
    articleId,
    title,
    summary,
    source,
    topicId,
    authorName,
    authorAvatar,
    image,
    publishedAt,
  ];
}
