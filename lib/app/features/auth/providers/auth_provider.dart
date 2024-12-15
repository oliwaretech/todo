
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo/app/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref);
});
final authProvider = Provider(AuthProvider.new);

class AuthProvider {
  AuthProvider(this.ref);
  final Ref ref;

  Future<void> signIn(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signIn(email: email, password: password);
  }

  Future<void> register(String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.register(email: email, password: password);
  }

  Future<void> registerUser(String name, String email, String password) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.registerUser(name: name, email: email, password: password);
  }
}