import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:erp_licitai_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:erp_licitai_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:erp_licitai_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:erp_licitai_mobile/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:erp_licitai_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:erp_licitai_mobile/features/auth/presentation/bloc/auth_event.dart';
import 'package:erp_licitai_mobile/features/auth/presentation/bloc/auth_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockCheckAuthUseCase extends Mock implements CheckAuthUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockCheckAuthUseCase mockCheckAuthUseCase;

  const testUser = UserEntity(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
  );

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockCheckAuthUseCase = MockCheckAuthUseCase();
    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      logoutUseCase: mockLogoutUseCase,
      checkAuthUseCase: mockCheckAuthUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, const AuthInitial());
    });

    group('AuthLoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when login succeeds',
        build: () {
          when(() => mockLoginUseCase(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testUser);
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthLoginRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [
          const AuthLoading(),
          const AuthAuthenticated(user: testUser),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase(
            email: 'test@example.com',
            password: 'password123',
          )).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when login fails',
        build: () {
          when(() => mockLoginUseCase(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception('Invalid credentials'));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthLoginRequested(
          email: 'test@example.com',
          password: 'wrongpassword',
        )),
        expect: () => [
          const AuthLoading(),
          isA<AuthError>(),
        ],
      );
    });

    group('AuthLogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] when logout succeeds',
        build: () {
          when(() => mockLogoutUseCase()).thenAnswer((_) async {});
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          const AuthUnauthenticated(),
        ],
        verify: (_) {
          verify(() => mockLogoutUseCase()).called(1);
        },
      );
    });

    group('AuthCheckStatus', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthAuthenticated] when token exists',
        build: () {
          when(() => mockCheckAuthUseCase()).thenAnswer((_) async => true);
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckStatus()),
        expect: () => [
          isA<AuthAuthenticated>(),
        ],
        verify: (_) {
          verify(() => mockCheckAuthUseCase()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] when no token exists',
        build: () {
          when(() => mockCheckAuthUseCase()).thenAnswer((_) async => false);
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckStatus()),
        expect: () => [
          const AuthUnauthenticated(),
        ],
        verify: (_) {
          verify(() => mockCheckAuthUseCase()).called(1);
        },
      );
    });
  });
}
