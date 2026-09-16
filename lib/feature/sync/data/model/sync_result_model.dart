import 'package:equatable/equatable.dart';
import 'package:news_task/feature/sync/data/model/sync_conflict_model.dart';

class SyncResultModel extends Equatable {
  final String? status;
  final int? newVersion;
  final List<String>? applied;
  final List<SyncConflictModel>? conflicts;

  const SyncResultModel({
    this.status,
    this.newVersion,
    this.applied,
    this.conflicts,
  });

  factory SyncResultModel.fromJson(Map<String, dynamic> json) =>
      SyncResultModel(
        status: json['status'] as String?,
        newVersion: json['newVersion'] as int?,
        applied: (json['applied'] as List?)?.cast<String>(),
        conflicts: (json['conflicts'] as List?)
            ?.map((e) => SyncConflictModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'newVersion': newVersion,
    'applied': applied,
    'conflicts': conflicts?.map((e) => e.toJson()).toList(),
  };

  int get appliedCount => applied?.length ?? 0;

  int get conflictCount => conflicts?.length ?? 0;

  @override
  List<Object?> get props => [status, newVersion, applied, conflicts];
}
