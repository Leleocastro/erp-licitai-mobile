import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../network/auth_interceptor.dart';
import '../routes/app_router.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/check_auth_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  const secureStorage = FlutterSecureStorage();
  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  // Network
  final dio = DioClient.create(
    baseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.licitai.com.br',
    ),
    secureStorage: secureStorage,
  );
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<AuthInterceptor>(
    () => dio.interceptors.whereType<AuthInterceptor>().first,
  );

  // Auth - Data
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      authInterceptor: getIt(),
    ),
  );

  // Auth - Domain
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<CheckAuthUseCase>(
    () => CheckAuthUseCase(repository: getIt()),
  );

  // Auth - Presentation
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt(),
      logoutUseCase: getIt(),
      checkAuthUseCase: getIt(),
    ),
  );

  // Routes
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(authInterceptor: getIt()),
  );
}
