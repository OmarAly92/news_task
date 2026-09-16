import 'package:equatable/equatable.dart';

class SyncConflictModel extends Equatable {
  final String? idempotencyKey;
  final String? articleId;
  final int? serverLikes;
  final bool? isLiked;
  final int? version;
  final String? reason;

  const SyncConflictModel({
    this.idempotencyKey,
    this.articleId,
    this.serverLikes,
    this.isLiked,
    this.version,
    this.reason,
  });

  factory SyncConflictModel.fromJson(Map<String, dynamic> json) =>
      SyncConflictModel(
        idempotencyKey: json['idempotencyKey'] as String?,
        articleId: json['articleId'] as String?,
        serverLikes: json['serverLikes'] as int?,
        isLiked: json['isLiked'] as bool?,
        version: json['version'] as int?,
        reason: json['reason'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'idempotencyKey': idempotencyKey,
    'articleId': articleId,
    'serverLikes': serverLikes,
    'isLiked': isLiked,
    'version': version,
    'reason': reason,
  };

  @override
  List<Object?> get props => [
    idempotencyKey,
    articleId,
    serverLikes,
    isLiked,
    version,
    reason,
  ];
}
