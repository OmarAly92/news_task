import 'package:equatable/equatable.dart';

class BookmarkSyncStateModel extends Equatable {
  final bool? bookmarked;
  final DateTime? updatedAt;

  const BookmarkSyncStateModel({this.bookmarked, this.updatedAt});

  factory BookmarkSyncStateModel.fromJson(Map<String, dynamic> json) =>
      BookmarkSyncStateModel(
        bookmarked: json['bookmarked'] as bool?,
        updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      );

  Map<String, dynamic> toJson() => {
    'bookmarked': bookmarked,
    'updatedAt': updatedAt?.toUtc().toIso8601String(),
  };

  @override
  List<Object?> get props => [bookmarked, updatedAt];
}
