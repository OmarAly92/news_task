import 'package:equatable/equatable.dart';
import 'package:news_task/feature/search/data/model/trending_topic_model.dart';

class TrendingModel extends Equatable {
  final String? date;
  final List<TrendingTopicModel>? topics;

  const TrendingModel({this.date, this.topics});

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
    date: json['date'] as String?,
    topics: (json['topics'] as List?)
        ?.map((e) => TrendingTopicModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'topics': topics?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [date, topics];
}
