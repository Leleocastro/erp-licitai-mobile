import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:erp_licitai_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:erp_licitai_mobile/features/auth/presentation/bloc/auth_state.dart';
import 'package:erp_licitai_mobile/features/auth/presentation/widgets/login_form.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestableWidget(Widget child) {
    return BlocProvider<AuthBloc>.value(
      value: mockAuthBloc,
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  group('LoginForm Widget', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      expect(find.byKey(const Key('core_login_input_email')), findsOneWidget);
      expect(find.byKey(const Key('core_login_input_senha')), findsOneWidget);
    });

    testWidgets('renders submit button', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      expect(find.byKey(const Key('core_login_btn_submit')), findsOneWidget);
      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets('shows validation error when email is empty', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      // Tap submit without entering email
      await tester.tap(find.byKey(const Key('core_login_btn_submit')));
      await tester.pumpAndSettle();

      expect(find.text('Informe seu e-mail'), findsOneWidget);
    });

    testWidgets('shows validation error when password is empty', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      // Enter email but not password
      await tester.enterText(
        find.byKey(const Key('core_login_input_email')),
        'test@example.com',
      );
      await tester.tap(find.byKey(const Key('core_login_btn_submit')));
      await tester.pumpAndSettle();

      expect(find.text('Informe sua senha'), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      await tester.enterText(
        find.byKey(const Key('core_login_input_email')),
        'invalidemail',
      );
      await tester.tap(find.byKey(const Key('core_login_btn_submit')));
      await tester.pumpAndSettle();

      expect(find.text('E-mail invalido'), findsOneWidget);
    });

    testWidgets('shows validation error for short password', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      await tester.enterText(
        find.byKey(const Key('core_login_input_email')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('core_login_input_senha')),
        '123',
      );
      await tester.tap(find.byKey(const Key('core_login_btn_submit')));
      await tester.pumpAndSettle();

      expect(find.text('Senha deve ter no minimo 6 caracteres'), findsOneWidget);
    });

    testWidgets('password field toggles visibility', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LoginForm()));

      // Initially password should be obscured (visibility icon should be visibility_off)
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Tap visibility toggle
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      // After toggle, should show visibility icon
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });
  });
}
