import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:open_insurance_mobile/core/api/api_exception.dart';
import 'package:open_insurance_mobile/core/api/identity_api_client.dart';
import 'package:open_insurance_mobile/core/models/login_request.dart';

void main() {
  group('IdentityApiClient', () {
    test('login returns LoginResponse on success', () async {
      final client = IdentityApiClient(
        httpClient: MockClient((request) async {
          expect(request.url.path, '/identity/auth/login');
          expect(request.method, 'POST');

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['email'], 'user@example.com');
          expect(body['password'], 'secret123');

          return http.Response(
            jsonEncode({
              'access_token': 'jwt-token',
              'token_type': 'Bearer',
              'expires_in': 3600,
            }),
            200,
          );
        }),
      );

      addTearDown(client.dispose);

      final response = await client.login(
        const LoginRequest(
          email: 'user@example.com',
          password: 'secret123',
        ),
      );

      expect(response.accessToken, 'jwt-token');
      expect(response.tokenType, 'Bearer');
      expect(response.expiresIn, 3600);
    });

    test('login throws ApiException with server error message', () async {
      final client = IdentityApiClient(
        httpClient: MockClient((request) async {
          return http.Response(
            jsonEncode({'error': 'invalid credentials'}),
            401,
          );
        }),
      );

      addTearDown(client.dispose);

      expect(
        () => client.login(
          const LoginRequest(
            email: 'user@example.com',
            password: 'wrong',
          ),
        ),
        throwsA(
          isA<ApiException>().having(
            (error) => error.message,
            'message',
            'invalid credentials',
          ),
        ),
      );
    });
  });
}
