import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/error_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'api_exception.dart';

class IdentityApiClient {
  IdentityApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _httpClient.post(
      ApiConfig.loginUri(),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    final body = _decodeBody(response.body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(body);
    }

    throw ApiException(
      message: _errorMessage(body, response.statusCode),
      statusCode: response.statusCode,
    );
  }

  Map<String, dynamic> _decodeBody(String body) {
    if (body.isEmpty) {
      return const {};
    }

    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return const {};
  }

  String _errorMessage(Map<String, dynamic> body, int statusCode) {
    if (body.containsKey('error')) {
      return ErrorResponse.fromJson(body).error;
    }

    return switch (statusCode) {
      400 => 'Invalid request. Check your email and password.',
      401 => 'Invalid credentials.',
      405 => 'Method not allowed.',
      >= 500 => 'Server error. Please try again later.',
      _ => 'Login failed. Please try again.',
    };
  }

  void dispose() => _httpClient.close();
}
