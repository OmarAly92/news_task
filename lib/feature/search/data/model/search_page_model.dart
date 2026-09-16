import 'package:equatable/equatable.dart';
import 'package:news_task/feature/search/data/model/search_result_model.dart';

class SearchPageModel extends Equatable {
  final String? query;
  final List<SearchResultModel>? data;
  final int? page;
  final int? pageSize;
  final int? total;

  const SearchPageModel({
    this.query,
    this.data,
    this.page,
    this.pageSize,
    this.total,
  });

  factory SearchPageModel.fromJson(Map<String, dynamic> json) =>
      SearchPageModel(
        query: json['query'] as String?,
        data: (json['data'] as List?)
            ?.map((e) => SearchResultModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        page: json['page'] as int?,
        pageSize: json['pageSize'] as int?,
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'query': query,
    'data': data?.map((e) => e.toJson()).toList(),
    'page': page,
    'pageSize': pageSize,
    'total': total,
  };

  @override
  List<Object?> get props => [query, data, page, pageSize, total];
}
