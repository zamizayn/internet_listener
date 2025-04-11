import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectionStatus {
  connected,
  disconnected,
}

class ConnectionService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectionStatus> _connectionStatusController =
      StreamController<ConnectionStatus>.broadcast();

  Stream<ConnectionStatus> get connectionStatusStream =>
      _connectionStatusController.stream;

  ConnectionService._internal() {
    _initialize();
  }

  static final ConnectionService _instance = ConnectionService._internal();

  factory ConnectionService() => _instance;

  void _initialize() async {
    // Check initial status
    final result = await _connectivity.checkConnectivity();
    _connectionStatusController.add(_getStatusFromResult(result));

    // Listen to status changes
    // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   _connectionStatusController.add(_getStatusFromResult(result));
    // });
    _connectivity.onConnectivityChanged.listen((event) {
        _connectionStatusController.add(_getStatusFromResult(event));
    },);
  }

  ConnectionStatus _getStatusFromResult(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      return ConnectionStatus.connected;
    } else {
      return ConnectionStatus.disconnected;
    }
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
