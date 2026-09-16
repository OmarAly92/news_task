import 'package:equatable/equatable.dart';

class SearchArticlesParams extends Equatable {
  final String query;
  final int? page;
  final int? pageSize;
  final String? topicId;
  final String? source;
  final DateTime? from;
  final DateTime? to;

  const SearchArticlesParams({
    required this.query,
    this.page,
    this.pageSize,
    this.topicId,
    this.source,
    this.from,
    this.to,
  });

  Map<String, dynamic> toJson() => {
    'q': query,
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (topicId != null) 'topic': topicId,
    if (source != null) 'source': source,
    if (from != null) 'from': from!.toUtc().toIso8601String(),
    if (to != null) 'to': to!.toUtc().toIso8601String(),
  };

  @override
  List<Object?> get props => [query, page, pageSize, topicId, source, from, to];
}
