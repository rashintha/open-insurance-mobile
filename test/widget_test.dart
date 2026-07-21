import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:open_insurance_mobile/core/services/auth_service.dart';
import 'package:open_insurance_mobile/features/auth/login_screen.dart';

void main() {
  testWidgets('Login screen renders email and password fields', (
    WidgetTester tester,
  ) async {
    final authService = AuthService();

    addTearDown(authService.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(authService: authService),
      ),
    );

    expect(find.text('Open Insurance'), findsOneWidget);
    expect(find.text('Sign in to your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.widgetWithText(FilledButton, 'Sign In'), findsOneWidget);
  });
}
