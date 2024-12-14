import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:todo/app/common/helpers/constans.dart';
import 'package:todo/app/common/providers/secure_storage_provider.dart';
import 'package:todo/app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  final Ref ref;
  AuthRepositoryImpl( this.ref);

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Uri url = Uri.parse('$reqResUrl/login');
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      final authUser = jsonDecode(response.body);
      final userToken = authUser['token'];
      ref.read(secureStorageProvider.notifier).saveToken(userToken);
    } catch (e) {
      rethrow;
    }
  }
}