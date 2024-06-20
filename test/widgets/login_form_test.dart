import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/widgets/login_form.dart';

void main() {
  group('Login form validations', () {
    testWidgets('Email, password and button exists', (tester) async {
      Widget loginFormWidget = const LoginForm();
      await tester.pumpWidget(MaterialApp(
        home: loginFormWidget,
      ));

      final emailField = find.descendant(
        of: find.byKey(const Key('emailTextFormField')),
        matching: find.byType(EditableText),
      );
      final passwordField = find.descendant(
        of: find.byKey(const Key('passwordTextFormField')),
        matching: find.byType(EditableText),
      );
      final loginButton = find.byKey(
        const Key('loginFormButton'),
      );

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });

    testWidgets('Password is obscured', (tester) async {
      Widget loginFormWidget = const LoginForm();
      await tester.pumpWidget(MaterialApp(
        home: loginFormWidget,
      ));

      final passwordField = find.descendant(
        of: find.byKey(const Key('passwordTextFormField')),
        matching: find.byType(EditableText),
      );

      final input = tester.widget<EditableText>(passwordField);
      expect(input.obscureText, isTrue);
    });

    testWidgets('Testing TextFormFields: empty fields', (tester) async {
      Widget loginFormWidget = const LoginForm();
      await tester.pumpWidget(MaterialApp(
        home: loginFormWidget,
      ));

      final loginButton = find.byKey(
        const Key('loginFormButton'),
      );

      final emailErrorFinder = find.text('Email is required');
      final passwordErrorFinder = find.text('Password is required');

      // Empty fields
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      expect(emailErrorFinder, findsOneWidget);
      expect(passwordErrorFinder, findsOneWidget);
    });

    testWidgets('Testing TextFormFields: invalid email/password', (tester) async {
      Widget loginFormWidget = const LoginForm();
      await tester.pumpWidget(MaterialApp(
        home: loginFormWidget,
      ));

      // Find the widgets
      final loginButton = find.byKey(
        const Key('loginFormButton'),
      );
      final passwordField = find.descendant(
        of: find.byKey(const Key('passwordTextFormField')),
        matching: find.byType(EditableText),
      );
      final emailField = find.descendant(
        of: find.byKey(const Key('emailTextFormField')),
        matching: find.byType(EditableText),
      );

      // Insert desired input
      await tester.enterText(emailField, 'batata.com');
      await tester.enterText(passwordField, 'password');

      // Find desired error messages
      final emailErrorFinder = find.text('Invalid email');
      final passwordErrorFinder = find.text(
          'Password must have special characters, numbers, lower and upper case letters');

      // Empty fields
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      expect(emailErrorFinder, findsOneWidget);
      expect(passwordErrorFinder, findsOneWidget);
    });

    testWidgets('Testing TextFormFields: valid fields', (tester) async {
      Widget loginFormWidget = const LoginForm();
      await tester.pumpWidget(MaterialApp(
        home: loginFormWidget,
      ));

      // Find the widgets
      final loginButton = find.byKey(
        const Key('loginFormButton'),
      );
      final passwordField = find.descendant(
        of: find.byKey(const Key('passwordTextFormField')),
        matching: find.byType(EditableText),
      );
      final emailField = find.descendant(
        of: find.byKey(const Key('emailTextFormField')),
        matching: find.byType(EditableText),
      );

      // Insert desired input
      await tester.enterText(emailField, 'teste@batata.com');
      await tester.enterText(passwordField, '#Password123');

      // Find desired success message
      final snackbarSuccessMessage = find.text('Processing Data');

      // Empty fields
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      expect(snackbarSuccessMessage, findsOneWidget);
    });
  });
}
