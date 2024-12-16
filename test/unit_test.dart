import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

// Mock classes
class MockHttpClient extends Mock implements http.Client {}

class MockSecureStorageNotifier extends StateNotifier<void> {
  MockSecureStorageNotifier() : super(null);

  void saveToken(String token) {
    // Intentionally empty for mocking
  }
}

// Provider setup
final secureStorageProvider = StateNotifierProvider<MockSecureStorageNotifier, void>(
      (ref) => MockSecureStorageNotifier(),
);

// AuthService implementation
class AuthService {
  final String reqResUrl;
  final Ref read;

  AuthService({
    required this.reqResUrl,
    required this.read,
  });

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
      read.read(secureStorageProvider.notifier).saveToken(userToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      Uri url = Uri.parse('$reqResUrl/register');
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      final authUser = jsonDecode(response.body);
      final userToken = authUser['token'];
      read.read(secureStorageProvider.notifier).saveToken(userToken);
    } catch (e) {
      rethrow;
    }
  }
}


// Unit tests
void main() {
  late MockHttpClient mockHttpClient;
  late MockSecureStorageNotifier mockSecureStorageNotifier;
  late AuthService authService;
  late ProviderContainer container;

  const reqResUrl = 'https://example.com';

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSecureStorageNotifier = MockSecureStorageNotifier();

    // Create a container with the overridden provider
    container = ProviderContainer(
      overrides: [
        secureStorageProvider.overrideWith(
              (ref) => mockSecureStorageNotifier,
        ),
      ],
    );

    authService = AuthService(
      reqResUrl: reqResUrl,
      read: container.read,
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthService', () {
    const email = 'test@example.com';
    const password = 'password123';
    const token = 'mockToken';

    test('signIn() should save token on successful response', () async {
      // Arrange
      final url = Uri.parse('$reqResUrl/login');
      when(() => mockHttpClient.post(
        url,
        body: {'email': email, 'password': password},
      )).thenAnswer(
            (_) async => http.Response(jsonEncode({'token': token}), 200),
      );

      when(() => mockSecureStorageNotifier.saveToken(any())).thenReturn(null);

      // Act
      await authService.signIn(email: email, password: password);

      // Assert
      verify(() => mockSecureStorageNotifier.saveToken(token)).called(1);
    });

    test('register() should save token on successful response', () async {
      // Arrange
      final url = Uri.parse('$reqResUrl/register');
      when(() => mockHttpClient.post(
        url,
        body: {'email': email, 'password': password},
      )).thenAnswer(
            (_) async => http.Response(jsonEncode({'token': token}), 200),
      );

      when(() => mockSecureStorageNotifier.saveToken(any())).thenReturn(null);

      // Act
      await authService.register(email: email, password: password);

      // Assert
      verify(() => mockSecureStorageNotifier.saveToken(token)).called(1);
    });

    test('signIn() should rethrow exceptions on error', () async {
      // Arrange
      final url = Uri.parse('$reqResUrl/login');
      when(() => mockHttpClient.post(
        url,
        body: {'email': email, 'password': password},
      )).thenThrow(Exception('Failed to log in'));

      // Act & Assert
      expect(
            () => authService.signIn(email: email, password: password),
        throwsA(isA<Exception>()),
      );
    });

    test('register() should rethrow exceptions on error', () async {
      // Arrange
      final url = Uri.parse('$reqResUrl/register');
      when(() => mockHttpClient.post(
        url,
        body: {'email': email, 'password': password},
      )).thenThrow(Exception('Failed to register'));

      // Act & Assert
      expect(
            () => authService.register(email: email, password: password),
        throwsA(isA<Exception>()),
      );
    });
  });
}
