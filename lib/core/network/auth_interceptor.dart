import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  static const _tokenKey = 'jwt_token';
  static const _refreshTokenKey = 'refresh_token';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: _tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await secureStorage.delete(key: _tokenKey);
      await secureStorage.delete(key: _refreshTokenKey);
    }
    handler.next(err);
  }

  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> clearToken() async {
    await secureStorage.delete(key: _tokenKey);
  }

  Future<String?> getToken() async {
    return secureStorage.read(key: _tokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await secureStorage.write(key: _refreshTokenKey, value: token);
  }

  Future<void> clearRefreshToken() async {
    await secureStorage.delete(key: _refreshTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return secureStorage.read(key: _refreshTokenKey);
  }
}
