import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkStatus {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkStatusImp implements NetworkStatus {
  NetworkStatusImp(this.internetConnection);

  final InternetConnection internetConnection;

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;

  @override
  Stream<bool> get onConnectivityChanged {
    return internetConnection.onStatusChange.map((status) {
      return status == InternetStatus.connected;
    });
  }
}
