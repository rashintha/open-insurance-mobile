import 'package:flutter/foundation.dart';

/// API configuration for the Kong gateway.
///
/// Override at build time with:
/// `--dart-define=API_BASE_URL=http://192.168.1.10:8000`
class ApiConfig {
  ApiConfig._();

  static const String loginPath = '/identity/auth/login';

  static String get baseUrl {
    const fromEnv = String.fromEnvironment('API_BASE_URL');
    if (fromEnv.isNotEmpty) {
      return fromEnv.endsWith('/') ? fromEnv.substring(0, fromEnv.length - 1) : fromEnv;
    }

    if (kIsWeb) {
      return 'http://localhost:8000';
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'http://10.0.2.2:8000',
      _ => 'http://localhost:8000',
    };
  }

  static Uri loginUri() => Uri.parse('$baseUrl$loginPath');
}
