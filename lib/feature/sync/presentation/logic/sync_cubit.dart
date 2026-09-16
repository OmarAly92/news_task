import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/error_handling/failures/failure.dart';
import 'package:news_task/core/helpers/network/logic/network_cubit.dart';
import 'package:news_task/core/helpers/result/result.dart';
import 'package:news_task/feature/sync/data/repository/sync_repository.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncState> {
  SyncCubit(this._repository, this._networkCubit)
    : super(const SyncInitialState()) {
    _restoredSubscription = _networkCubit.onRestored.listen((_) => sync());
    sync();
  }

  static const Duration retryDelay = Duration(seconds: 30);
  static const Duration _bannerDuration = Duration(milliseconds: 2500);

  final SyncRepository _repository;
  final NetworkCubit _networkCubit;

  bool isSyncing = false;
  int pendingCount = 0;
  DateTime? lastSyncedAt;

  StreamSubscription<void>? _restoredSubscription;
  Timer? _retryTimer;
  Timer? _bannerTimer;

  Future<void> sync() async {
    if (isSyncing) return;
    _retryTimer?.cancel();
    pendingCount = await _repository.pendingCount();
    if (pendingCount == 0) return;
    isSyncing = true;
    _bannerTimer?.cancel();
    emit(SyncLoadingState(pendingCount));
    final result = await _repository.sync();
    isSyncing = false;
    result.when(
      onSuccess: (data) {
        lastSyncedAt = DateTime.now();
        pendingCount = 0;
        emit(
          SyncSuccessState(
            applied: data?.appliedCount ?? 0,
            conflicts: data?.conflictCount ?? 0,
            at: lastSyncedAt!,
          ),
        );
        _hideBannerLater();
        _syncAgainIfNeeded();
      },
      onFailure: (failure) {
        emit(SyncFailureState(failure: failure, at: DateTime.now()));
        _hideBannerLater();
        if (_networkCubit.isOnline) _retryTimer = Timer(retryDelay, sync);
      },
    );
  }

  Future<void> _syncAgainIfNeeded() async {
    if (await _repository.pendingCount() > 0) sync();
  }

  void _hideBannerLater() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer(_bannerDuration, () {
      if (!isClosed && !isSyncing) emit(const SyncIdleState());
    });
  }

  @override
  Future<void> close() {
    _restoredSubscription?.cancel();
    _retryTimer?.cancel();
    _bannerTimer?.cancel();
    return super.close();
  }
}
