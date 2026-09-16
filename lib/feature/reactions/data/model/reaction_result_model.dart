import 'package:equatable/equatable.dart';
import 'package:news_task/feature/reactions/data/model/reaction_server_state_model.dart';

class ReactionResultModel extends Equatable {
  final String? status;
  final String? articleId;
  final String? reaction;
  final int? likes;
  final int? version;
  final ReactionServerStateModel? serverState;
  final String? code;
  final String? message;

  const ReactionResultModel({
    this.status,
    this.articleId,
    this.reaction,
    this.likes,
    this.version,
    this.serverState,
    this.code,
    this.message,
  });

  factory ReactionResultModel.fromJson(Map<String, dynamic> json) =>
      ReactionResultModel(
        status: json['status'] as String?,
        articleId: json['articleId'] as String?,
        reaction: json['reaction'] as String?,
        likes: json['likes'] as int?,
        version: json['version'] as int?,
        serverState: json['serverState'] == null
            ? null
            : ReactionServerStateModel.fromJson(
                json['serverState'] as Map<String, dynamic>,
              ),
        code: json['code'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'articleId': articleId,
    'reaction': reaction,
    'likes': likes,
    'version': version,
    'serverState': serverState?.toJson(),
    'code': code,
    'message': message,
  };

  bool get isSuccess => status == 'success';

  bool get isConflict => status == 'conflict';

  bool get isQueued => status == 'queued';

  @override
  List<Object?> get props => [
    status,
    articleId,
    reaction,
    likes,
    version,
    serverState,
    code,
    message,
  ];
}
