import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityResult> _connectivityStreamController =
      StreamController<ConnectivityResult>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityStreamController.add(result);
    });
  }

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityStreamController.stream;

  Future<ConnectivityResult> checkConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

  void dispose() {
    _connectivityStreamController.close();
  }
}
