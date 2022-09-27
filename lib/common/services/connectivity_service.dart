import 'package:connectivity_plus/connectivity_plus.dart';

import '../../features/credentials/repository/credentials_repository.dart';

class ConnectivityService {
  static late final Connectivity _connectivity = Connectivity();

  final _connectivitySubscription = _connectivity.onConnectivityChanged
      .listen(CredentialsRepository.syncTheData);

  static Future<bool> isConnected({
    ConnectivityResult? connectivityResult,
  }) async {
    // ignore: parameter_assignments
    connectivityResult ??= await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Future<void> dispose() {
    return _connectivitySubscription.cancel();
  }
}
