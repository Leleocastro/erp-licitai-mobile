import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/di/service_locator.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();

    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: MaterialApp.router(
        title: 'ERP Licitai',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: router.router,
      ),
    );
  }
}
