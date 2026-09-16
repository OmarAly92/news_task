import 'package:equatable/equatable.dart';

class GetFeedUpdatesParams extends Equatable {
  final DateTime? since;

  const GetFeedUpdatesParams({this.since});

  Map<String, dynamic> toJson() => {
    if (since != null) 'since': since!.toUtc().toIso8601String(),
  };

  @override
  List<Object?> get props => [since];
}
