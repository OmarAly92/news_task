part of 'network_cubit.dart';

sealed class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object?> get props => [];
}

final class NetworkInitialState extends NetworkState {
  const NetworkInitialState();
}

final class NetworkOnlineState extends NetworkState {
  const NetworkOnlineState();
}

final class NetworkOfflineState extends NetworkState {
  const NetworkOfflineState();
}
