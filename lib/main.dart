import 'package:flutter/material.dart';

import 'core/services/auth_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(const OpenInsuranceApp());
}

class OpenInsuranceApp extends StatefulWidget {
  const OpenInsuranceApp({super.key});

  @override
  State<OpenInsuranceApp> createState() => _OpenInsuranceAppState();
}

class _OpenInsuranceAppState extends State<OpenInsuranceApp> {
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Insurance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: FutureBuilder<bool>(
        future: _authService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final isLoggedIn = snapshot.data ?? false;
          if (isLoggedIn) {
            return HomeScreen(authService: _authService);
          }

          return LoginScreen(authService: _authService);
        },
      ),
    );
  }
}
