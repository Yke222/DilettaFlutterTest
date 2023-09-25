import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetConnection {
  Future<bool> call() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}