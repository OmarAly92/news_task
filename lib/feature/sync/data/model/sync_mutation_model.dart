import 'package:equatable/equatable.dart';

class SyncMutationModel extends Equatable {
  final String? op;
  final String? idempotencyKey;
  final Map<String, dynamic>? payload;

  const SyncMutationModel({this.op, this.idempotencyKey, this.payload});

  factory SyncMutationModel.fromJson(Map<String, dynamic> json) =>
      SyncMutationModel(
        op: json['op'] as String?,
        idempotencyKey: json['idempotencyKey'] as String?,
        payload: (json['payload'] as Map?)?.cast<String, dynamic>(),
      );

  Map<String, dynamic> toJson() => {
    'op': op,
    'idempotencyKey': idempotencyKey,
    'payload': payload,
  };

  bool get isReaction => op == 'set_reaction';

  bool get isBookmark => op == 'set_bookmark';

  String? get articleId => payload?['articleId'] as String?;

  @override
  List<Object?> get props => [op, idempotencyKey, payload];
}
