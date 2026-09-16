import 'package:equatable/equatable.dart';

class GetCachedFeedParams extends Equatable {
  final String? topicId;

  const GetCachedFeedParams({this.topicId});

  @override
  List<Object?> get props => [topicId];
}
