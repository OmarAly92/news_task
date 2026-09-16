import 'package:equatable/equatable.dart';
import 'package:news_task/core/database/app_database.dart';

class BookmarkModel extends Equatable {
  final String? articleId;
  final String? title;
  final String? summary;
  final String? source;
  final String? topicId;
  final String? authorName;
  final String? authorAvatar;
  final String? image;
  final DateTime? publishedAt;
  final DateTime? savedAt;
  final bool? isSynced;
  final bool? pendingRemoval;

  const BookmarkModel({
    this.articleId,
    this.title,
    this.summary,
    this.source,
    this.topicId,
    this.authorName,
    this.authorAvatar,
    this.image,
    this.publishedAt,
    this.savedAt,
    this.isSynced,
    this.pendingRemoval,
  });

  factory BookmarkModel.fromDB(BookmarkEntity entity) => BookmarkModel(
    articleId: entity.articleId,
    title: entity.title,
    summary: entity.summary,
    source: entity.source,
    topicId: entity.topicId,
    authorName: entity.authorName,
    authorAvatar: entity.authorAvatar,
    image: entity.image,
    publishedAt: entity.publishedAt,
    savedAt: entity.savedAt,
    isSynced: entity.isSynced,
    pendingRemoval: entity.pendingRemoval,
  );

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
    savedAt,
    isSynced,
    pendingRemoval,
  ];
}
