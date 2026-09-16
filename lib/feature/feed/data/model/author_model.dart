import 'package:equatable/equatable.dart';

class AuthorModel extends Equatable {
  final String? id;
  final String? name;
  final String? avatar;
  final String? bio;

  const AuthorModel({this.id, this.name, this.avatar, this.bio});

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    avatar: json['avatar'] as String?,
    bio: json['bio'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'bio': bio,
  };

  @override
  List<Object?> get props => [id, name, avatar, bio];
}
