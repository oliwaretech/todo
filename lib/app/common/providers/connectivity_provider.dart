import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Define a StateNotifier to manage connectivity state
class ConnectivityNotifier extends StateNotifier<List<ConnectivityResult>?> {
  ConnectivityNotifier() : super(null) {
    _initialize();
  }

  Future<void> _initialize() async {
    // Get the initial connectivity status
    final result = await Connectivity().checkConnectivity();
    state = result;

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((result) {
      state = result; // Assigning the single ConnectivityResult
    });
  }
}

// Create a provider for the ConnectivityNotifier
final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, List<ConnectivityResult>?>((ref) {
  return ConnectivityNotifier();
});
