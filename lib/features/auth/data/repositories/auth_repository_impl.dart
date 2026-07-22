import '../../../../core/network/auth_interceptor.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthInterceptor authInterceptor,
  })  : _remoteDataSource = remoteDataSource,
        _authInterceptor = authInterceptor;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthInterceptor _authInterceptor;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final authModel = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    await _authInterceptor.saveToken(authModel.accessToken);
    await _authInterceptor.saveRefreshToken(authModel.refreshToken);

    return _toEntity(authModel);
  }

  @override
  Future<void> logout() async {
    final refreshToken = await _authInterceptor.getRefreshToken();
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await _remoteDataSource.logout(refreshToken: refreshToken);
      } catch (_) {
        // Ignore logout API errors, clear local state anyway
      }
    }
    await _authInterceptor.clearToken();
    await _authInterceptor.clearRefreshToken();
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await _authInterceptor.getToken();
    return token != null && token.isNotEmpty;
  }

  UserEntity _toEntity(AuthModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      name: model.name,
      cpf: model.cpf,
      orgaoId: model.orgaoId,
      roles: model.roles,
    );
  }
}
