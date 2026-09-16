import 'package:equatable/equatable.dart';

class ReactionServerStateModel extends Equatable {
  final bool? isLiked;
  final int? likes;
  final int? version;

  const ReactionServerStateModel({this.isLiked, this.likes, this.version});

  factory ReactionServerStateModel.fromJson(Map<String, dynamic> json) =>
      ReactionServerStateModel(
        isLiked: json['isLiked'] as bool?,
        likes: json['likes'] as int?,
        version: json['version'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'isLiked': isLiked,
    'likes': likes,
    'version': version,
  };

  @override
  List<Object?> get props => [isLiked, likes, version];
}
