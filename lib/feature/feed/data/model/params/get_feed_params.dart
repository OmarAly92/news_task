import 'package:equatable/equatable.dart';

class GetFeedParams extends Equatable {
  final int? page;
  final int? pageSize;
  final String? cursor;
  final String? topicId;
  final String? source;

  const GetFeedParams({
    this.page,
    this.pageSize,
    this.cursor,
    this.topicId,
    this.source,
  });

  Map<String, dynamic> toJson() => {
    if (cursor != null) 'cursor': cursor,
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (topicId != null) 'topic': topicId,
    if (source != null) 'source': source,
  };

  @override
  List<Object?> get props => [page, pageSize, cursor, topicId, source];
}
