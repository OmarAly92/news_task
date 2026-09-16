import 'package:equatable/equatable.dart';

class GetArticleParams extends Equatable {
  final String articleId;

  const GetArticleParams({required this.articleId});

  Map<String, dynamic> toJson() => {'articleId': articleId};

  @override
  List<Object?> get props => [articleId];
}
