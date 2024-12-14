import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecureStorageNotifier extends StateNotifier<String?> {
  final FlutterSecureStorage _secureStorage;

  SecureStorageNotifier(this._secureStorage) : super(null) {
    _initialize();
  }

  // Initialize the state by reading the token from secure storage
  Future<void> _initialize() async {
    final token = await _secureStorage.read(key: 'auth_token');
    state = token;
  }

  // Save token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
    state = token;
  }

  // Read token
  Future<void> readToken() async {
    final token = await _secureStorage.read(key: 'auth_token');
    state = token;
  }

  // Delete token
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
    state = null;
  }
}

final secureStorageProvider = StateNotifierProvider<SecureStorageNotifier, String?>((ref) {
  return SecureStorageNotifier(const FlutterSecureStorage());
});
