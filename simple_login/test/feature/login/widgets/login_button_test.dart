import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_login/features/login/bloc/login_state.dart';
import 'package:simple_login/features/login/widgets/login_button.dart';

void main() {
  group(
    'LoginButton Tests',
    () {
      testWidgets(
        'render CircularProgressIndicator',
        (tester) async {
          const state = LoginState(
            email: '',
            password: '',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.loading,
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: LoginButton(
                  state: state,
                ),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(find.text('Entrar'), findsNothing);
        },
      );

      testWidgets(
        'renders FilledButton when loginStatus is not loading',
        (tester) async {
          const state = LoginState(
            email: '',
            password: '',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.idle,
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: LoginButton(
                  state: state,
                ),
              ),
            ),
          );

          expect(find.byType(FilledButton), findsOneWidget);
          expect(find.text('Entrar'), findsOneWidget);
          final button = tester.widget<FilledButton>(find.byType(FilledButton));
          expect(button.enabled, false);
        },
      );

      testWidgets(
        'renders FilledButton',
        (tester) async {
          const state = LoginState(
            email: 'teste@test.com',
            password: '123456788aa',
            isEmailValid: true,
            isPasswordValid: true,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.idle,
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: LoginButton(
                  state: state,
                ),
              ),
            ),
          );

          expect(find.byType(FilledButton), findsOneWidget);
          expect(find.text('Entrar'), findsOneWidget);
          final button = tester.widget<FilledButton>(find.byType(FilledButton));
          expect(button.enabled, true);
        },
      );
    },
  );
}
