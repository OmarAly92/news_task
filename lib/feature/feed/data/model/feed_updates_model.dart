import 'package:equatable/equatable.dart';

class FeedUpdatesModel extends Equatable {
  final List<String>? newItems;
  final List<String>? updatedItems;
  final List<String>? deletedItems;
  final DateTime? serverTime;

  const FeedUpdatesModel({
    this.newItems,
    this.updatedItems,
    this.deletedItems,
    this.serverTime,
  });

  factory FeedUpdatesModel.fromJson(Map<String, dynamic> json) =>
      FeedUpdatesModel(
        newItems: (json['newItems'] as List?)?.cast<String>(),
        updatedItems: (json['updatedItems'] as List?)?.cast<String>(),
        deletedItems: (json['deletedItems'] as List?)?.cast<String>(),
        serverTime: DateTime.tryParse(json['serverTime'] as String? ?? ''),
      );

  Map<String, dynamic> toJson() => {
    'newItems': newItems,
    'updatedItems': updatedItems,
    'deletedItems': deletedItems,
    'serverTime': serverTime?.toUtc().toIso8601String(),
  };

  @override
  List<Object?> get props => [newItems, updatedItems, deletedItems, serverTime];
}
