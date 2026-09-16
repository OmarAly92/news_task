import 'package:equatable/equatable.dart';

class SuggestionsModel extends Equatable {
  final String? q;
  final List<String>? suggestions;

  const SuggestionsModel({this.q, this.suggestions});

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) =>
      SuggestionsModel(
        q: json['q'] as String?,
        suggestions: (json['suggestions'] as List?)?.cast<String>(),
      );

  Map<String, dynamic> toJson() => {'q': q, 'suggestions': suggestions};

  @override
  List<Object?> get props => [q, suggestions];
}
