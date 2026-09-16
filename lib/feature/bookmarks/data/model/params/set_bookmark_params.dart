import 'package:equatable/equatable.dart';

class SetBookmarkParams extends Equatable {
  final String articleId;
  final bool bookmarked;

  const SetBookmarkParams({required this.articleId, required this.bookmarked});

  Map<String, dynamic> toJson() => {'bookmarked': bookmarked};

  @override
  List<Object?> get props => [articleId, bookmarked];
}
