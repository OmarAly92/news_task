import 'package:equatable/equatable.dart';

class SetReactionParams extends Equatable {
  final String articleId;
  final String reaction;
  final String clientMutationId;
  final int? expectedVersion;

  const SetReactionParams({
    required this.articleId,
    required this.reaction,
    required this.clientMutationId,
    this.expectedVersion,
  });

  Map<String, dynamic> toJson() => {
    'reaction': reaction,
    'clientMutationId': clientMutationId,
    if (expectedVersion != null) 'expectedVersion': expectedVersion,
  };

  @override
  List<Object?> get props => [
    articleId,
    reaction,
    clientMutationId,
    expectedVersion,
  ];
}
