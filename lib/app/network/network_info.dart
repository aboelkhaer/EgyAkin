import '../../exports.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  /// Emits `true` when online, `false` when offline.
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker _connectionChecker;
  NetworkInfoImpl(this._connectionChecker);
  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;

  @override
  Stream<bool> get onConnectivityChanged =>
      _connectionChecker.onStatusChange.map(
        (status) => status == InternetConnectionStatus.connected,
      );
}
