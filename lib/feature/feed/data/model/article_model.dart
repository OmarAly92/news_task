import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:news_task/core/database/app_database.dart';
import 'package:news_task/feature/feed/data/model/author_model.dart';

class ArticleModel extends Equatable {
  final String? id;
  final String? title;
  final String? summary;
  final String? source;
  final AuthorModel? author;
  final String? topicId;
  final DateTime? publishedAt;
  final String? image;
  final List<String>? tags;
  final int? likes;
  final int? comments;
  final bool? isLiked;
  final bool? isBookmarked;
  final int? version;

  const ArticleModel({
    this.id,
    this.title,
    this.summary,
    this.source,
    this.author,
    this.topicId,
    this.publishedAt,
    this.image,
    this.tags,
    this.likes,
    this.comments,
    this.isLiked,
    this.isBookmarked,
    this.version,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    id: json['id'] as String?,
    title: json['title'] as String?,
    summary: json['summary'] as String?,
    source: json['source'] as String?,
    author: json['author'] == null
        ? null
        : AuthorModel.fromJson(json['author'] as Map<String, dynamic>),
    topicId: json['topicId'] as String?,
    publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
    image: json['image'] as String?,
    tags: (json['tags'] as List?)?.cast<String>(),
    likes: json['likes'] as int?,
    comments: json['comments'] as int?,
    isLiked: json['isLiked'] as bool?,
    isBookmarked: json['isBookmarked'] as bool?,
    version: json['version'] as int?,
  );

  factory ArticleModel.fromDB(FeedItemEntity entity) => ArticleModel(
    id: entity.articleId,
    title: entity.title,
    summary: entity.summary,
    source: entity.source,
    author: entity.authorName == null && entity.authorAvatar == null
        ? null
        : AuthorModel(
            id: entity.authorId,
            name: entity.authorName,
            avatar: entity.authorAvatar,
          ),
    topicId: entity.topicId,
    publishedAt: entity.publishedAt,
    image: entity.image,
    tags: (jsonDecode(entity.tags ?? '[]') as List).cast<String>(),
    likes: entity.likes,
    comments: entity.comments,
    isLiked: entity.isLiked,
    isBookmarked: false,
    version: entity.version,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'source': source,
    'author': author?.toJson(),
    'topicId': topicId,
    'publishedAt': publishedAt?.toUtc().toIso8601String(),
    'image': image,
    'tags': tags,
    'likes': likes,
    'comments': comments,
    'isLiked': isLiked,
    'isBookmarked': isBookmarked,
    'version': version,
  };

  ArticleModel copyWith({
    int? likes,
    bool? isLiked,
    bool? isBookmarked,
    int? version,
  }) => ArticleModel(
    id: id,
    title: title,
    summary: summary,
    source: source,
    author: author,
    topicId: topicId,
    publishedAt: publishedAt,
    image: image,
    tags: tags,
    likes: likes ?? this.likes,
    comments: comments,
    isLiked: isLiked ?? this.isLiked,
    isBookmarked: isBookmarked ?? this.isBookmarked,
    version: version ?? this.version,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    summary,
    source,
    author,
    topicId,
    publishedAt,
    image,
    tags,
    likes,
    comments,
    isLiked,
    isBookmarked,
    version,
  ];
}
