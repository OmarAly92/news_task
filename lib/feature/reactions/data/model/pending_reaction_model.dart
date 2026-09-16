import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:news_task/core/database/app_database.dart';

class PendingReactionModel extends Equatable {
  final String? articleId;
  final String? reaction;
  final String? idempotencyKey;
  final DateTime? createdAt;

  const PendingReactionModel({
    this.articleId,
    this.reaction,
    this.idempotencyKey,
    this.createdAt,
  });

  factory PendingReactionModel.fromDB(OutboxEntity entity) {
    final payload = jsonDecode(entity.payload) as Map<String, dynamic>;
    return PendingReactionModel(
      articleId: entity.articleId,
      reaction: payload['reaction'] as String?,
      idempotencyKey: entity.idempotencyKey,
      createdAt: entity.createdAt,
    );
  }

  bool get isLike => reaction == 'like';

  @override
  List<Object?> get props => [articleId, reaction, idempotencyKey, createdAt];
}
