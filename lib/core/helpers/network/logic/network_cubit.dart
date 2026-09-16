import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_task/core/helpers/network/network_status.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(this._networkStatus) : super(const NetworkInitialState()) {
    _sub = _networkStatus.onConnectivityChanged.listen(_onChanged);
    _seed();
  }

  final NetworkStatus _networkStatus;
  final StreamController<void> _restored = StreamController<void>.broadcast();

  StreamSubscription<bool>? _sub;
  bool _isOnline = true;
  bool _hasStreamValue = false;

  bool get isOnline => _isOnline;

  Stream<void> get onRestored => _restored.stream;

  Future<void> _seed() async {
    final connected = await _networkStatus.isConnected;
    if (isClosed || _hasStreamValue) return;
    _apply(connected);
  }

  void _onChanged(bool connected) {
    if (isClosed) return;
    _hasStreamValue = true;
    _apply(connected);
  }

  void _apply(bool connected) {
    final wasResolved = state is! NetworkInitialState;
    if (wasResolved && connected == _isOnline) return;
    final wasOffline = wasResolved && !_isOnline;
    _isOnline = connected;
    emit(connected ? const NetworkOnlineState() : const NetworkOfflineState());
    if (connected && wasOffline) _restored.add(null);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _restored.close();
    return super.close();
  }
}
