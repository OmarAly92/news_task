import 'package:equatable/equatable.dart';

class ReactionUpdateModel extends Equatable {
  final String? articleId;
  final bool? isLiked;
  final int? likes;
  final int? version;
  final bool? isPending;

  const ReactionUpdateModel({
    this.articleId,
    this.isLiked,
    this.likes,
    this.version,
    this.isPending,
  });

  @override
  List<Object?> get props => [articleId, isLiked, likes, version, isPending];
}
