import 'package:async/async.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkStatus {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkStatusImp implements NetworkStatus {
  NetworkStatusImp(this.internetConnection, this.connectivity) {
    _changes = StreamGroup.merge([
      internetConnection.onStatusChange.map(
        (status) => status == InternetStatus.connected,
      ),
      connectivity.onConnectivityChanged
          .where(_isDisconnected)
          .map((_) => false),
    ]).asBroadcastStream();
    _changes.listen((connected) => _lastKnown = connected);
  }

  final InternetConnection internetConnection;
  final Connectivity connectivity;

  late final Stream<bool> _changes;
  bool? _lastKnown;

  @override
  Future<bool> get isConnected async {
    if (_isDisconnected(await connectivity.checkConnectivity())) return false;
    return _lastKnown ?? await internetConnection.hasInternetAccess;
  }

  @override
  Stream<bool> get onConnectivityChanged => _changes;

  bool _isDisconnected(List<ConnectivityResult> results) =>
      results.isEmpty || results.every((r) => r == ConnectivityResult.none);
}
