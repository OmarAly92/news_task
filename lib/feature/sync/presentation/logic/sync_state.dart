part of 'sync_cubit.dart';

sealed class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object?> get props => [];
}

final class SyncInitialState extends SyncState {
  const SyncInitialState();
}

final class SyncIdleState extends SyncState {
  const SyncIdleState();
}

final class SyncLoadingState extends SyncState {
  const SyncLoadingState(this.pendingCount);

  final int pendingCount;

  @override
  List<Object?> get props => [pendingCount];
}

final class SyncSuccessState extends SyncState {
  const SyncSuccessState({
    required this.applied,
    required this.conflicts,
    required this.at,
  });

  final int applied;
  final int conflicts;
  final DateTime at;

  @override
  List<Object?> get props => [applied, conflicts, at];
}

final class SyncFailureState extends SyncState {
  const SyncFailureState({required this.failure, required this.at});

  final Failure failure;
  final DateTime at;

  @override
  List<Object?> get props => [failure, at];
}
