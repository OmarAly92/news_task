import 'package:equatable/equatable.dart';

class EnqueueReactionParams extends Equatable {
  final String articleId;
  final String reaction;
  final String idempotencyKey;

  const EnqueueReactionParams({
    required this.articleId,
    required this.reaction,
    required this.idempotencyKey,
  });

  @override
  List<Object?> get props => [articleId, reaction, idempotencyKey];
}
