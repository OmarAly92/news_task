import 'package:equatable/equatable.dart';

class GetSuggestionsParams extends Equatable {
  final String query;

  const GetSuggestionsParams({required this.query});

  Map<String, dynamic> toJson() => {'q': query};

  @override
  List<Object?> get props => [query];
}
