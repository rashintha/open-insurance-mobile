import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/api_exception.dart';
import '../api/identity_api_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthService {
  AuthService({
    IdentityApiClient? apiClient,
    FlutterSecureStorage? secureStorage,
  })  : _apiClient = apiClient ?? IdentityApiClient(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _tokenTypeKey = 'token_type';
  static const _expiresInKey = 'expires_in';

  final IdentityApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.login(
        LoginRequest(email: email.trim(), password: password),
      );

      await _persistSession(response);
      return response;
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException(
        message: 'Unable to reach the server. Check your connection.',
      );
    }
  }

  Future<void> _persistSession(LoginResponse response) async {
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: response.accessToken),
      _secureStorage.write(key: _tokenTypeKey, value: response.tokenType),
      _secureStorage.write(
        key: _expiresInKey,
        value: response.expiresIn.toString(),
      ),
    ]);
  }

  Future<String?> getAccessToken() => _secureStorage.read(key: _accessTokenKey);

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

  void dispose() => _apiClient.dispose();
}
