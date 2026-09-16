import 'package:equatable/equatable.dart';
import 'package:news_task/feature/sync/data/model/sync_mutation_model.dart';

class SyncParams extends Equatable {
  final int baseVersion;
  final List<SyncMutationModel> mutations;

  const SyncParams({required this.baseVersion, required this.mutations});

  Map<String, dynamic> toJson() => {
    'baseVersion': baseVersion,
    'mutations': mutations.map((m) => m.toJson()).toList(),
  };

  @override
  List<Object?> get props => [baseVersion, mutations];
}
