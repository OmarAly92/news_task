import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/feature/article/data/model/content_block_model.dart';
import 'package:news_task/feature/feed/data/model/author_model.dart';

class ArticleDetailsModel extends Equatable {
  final String? status;
  final String? reason;
  final String? id;
  final String? title;
  final String? summary;
  final List<ContentBlockModel>? body;
  final String? source;
  final AuthorModel? author;
  final String? topicId;
  final DateTime? publishedAt;
  final DateTime? updatedAt;
  final int? readTimeMinutes;
  final String? image;
  final List<String>? gallery;
  final List<String>? tags;
  final List<String>? related;
  final int? likes;
  final int? comments;
  final bool? isLiked;
  final bool? isBookmarked;
  final int? version;

  const ArticleDetailsModel({
    this.status,
    this.reason,
    this.id,
    this.title,
    this.summary,
    this.body,
    this.source,
    this.author,
    this.topicId,
    this.publishedAt,
    this.updatedAt,
    this.readTimeMinutes,
    this.image,
    this.gallery,
    this.tags,
    this.related,
    this.likes,
    this.comments,
    this.isLiked,
    this.isBookmarked,
    this.version,
  });

  factory ArticleDetailsModel.fromJson(Map<String, dynamic> json) =>
      ArticleDetailsModel(
        status: json['status'] as String?,
        reason: json['reason'] as String?,
        id: (json['id'] ?? json['articleId']) as String?,
        title: json['title'] as String?,
        summary: json['summary'] as String?,
        body: (json['body'] as List?)
            ?.map((e) => ContentBlockModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        source: json['source'] as String?,
        author: json['author'] == null
            ? null
            : AuthorModel.fromJson(json['author'] as Map<String, dynamic>),
        topicId: json['topicId'] as String?,
        publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
        readTimeMinutes: json['readTimeMinutes'] as int?,
        image: json['image'] as String?,
        gallery: (json['gallery'] as List?)?.cast<String>(),
        tags: (json['tags'] as List?)?.cast<String>(),
        related: (json['related'] as List?)?.cast<String>(),
        likes: json['likes'] as int?,
        comments: json['comments'] as int?,
        isLiked: json['isLiked'] as bool?,
        isBookmarked: json['isBookmarked'] as bool?,
        version: json['version'] as int?,
      );

  factory ArticleDetailsModel.fromDB(ArticleEntity entity) =>
      ArticleDetailsModel(
        id: entity.articleId,
        title: entity.title,
        summary: entity.summary,
        body: (jsonDecode(entity.body ?? '[]') as List)
            .map((e) => ContentBlockModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        source: entity.source,
        author: entity.authorName == null
            ? null
            : AuthorModel(
                id: entity.authorId,
                name: entity.authorName,
                avatar: entity.authorAvatar,
                bio: entity.authorBio,
              ),
        topicId: entity.topicId,
        publishedAt: entity.publishedAt,
        updatedAt: entity.updatedAt,
        readTimeMinutes: entity.readTimeMinutes,
        image: entity.image,
        gallery: (jsonDecode(entity.gallery ?? '[]') as List).cast<String>(),
        tags: (jsonDecode(entity.tags ?? '[]') as List).cast<String>(),
        related: (jsonDecode(entity.related ?? '[]') as List).cast<String>(),
        likes: entity.likes,
        comments: entity.comments,
        isLiked: entity.isLiked,
        isBookmarked: false,
        version: entity.version,
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'reason': reason,
    'id': id,
    'title': title,
    'summary': summary,
    'body': body?.map((e) => e.toJson()).toList(),
    'source': source,
    'author': author?.toJson(),
    'topicId': topicId,
    'publishedAt': publishedAt?.toUtc().toIso8601String(),
    'updatedAt': updatedAt?.toUtc().toIso8601String(),
    'readTimeMinutes': readTimeMinutes,
    'image': image,
    'gallery': gallery,
    'tags': tags,
    'related': related,
    'likes': likes,
    'comments': comments,
    'isLiked': isLiked,
    'isBookmarked': isBookmarked,
    'version': version,
  };

  ArticleDetailsModel copyWith({
    int? likes,
    bool? isLiked,
    bool? isBookmarked,
    int? version,
  }) => ArticleDetailsModel(
    status: status,
    reason: reason,
    id: id,
    title: title,
    summary: summary,
    body: body,
    source: source,
    author: author,
    topicId: topicId,
    publishedAt: publishedAt,
    updatedAt: updatedAt,
    readTimeMinutes: readTimeMinutes,
    image: image,
    gallery: gallery,
    tags: tags,
    related: related,
    likes: likes ?? this.likes,
    comments: comments,
    isLiked: isLiked ?? this.isLiked,
    isBookmarked: isBookmarked ?? this.isBookmarked,
    version: version ?? this.version,
  );

  bool get isUnavailable => status == 'unavailable';

  List<String> get images => [if (image != null) image!, ...?gallery];

  @override
  List<Object?> get props => [
    status,
    reason,
    id,
    title,
    summary,
    body,
    source,
    author,
    topicId,
    publishedAt,
    updatedAt,
    readTimeMinutes,
    image,
    gallery,
    tags,
    related,
    likes,
    comments,
    isLiked,
    isBookmarked,
    version,
  ];
}
