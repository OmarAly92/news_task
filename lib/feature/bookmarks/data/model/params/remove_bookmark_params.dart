import 'package:equatable/equatable.dart';

class RemoveBookmarkParams extends Equatable {
  final String articleId;

  const RemoveBookmarkParams({required this.articleId});

  @override
  List<Object?> get props => [articleId];
}
