import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../network/auth_interceptor.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  AppRouter({required this.authInterceptor});

  final AuthInterceptor authInterceptor;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    redirect: _redirect,
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );

  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final token = await authInterceptor.getToken();
    final isAuthRoute = state.matchedLocation == '/login';

    if (token == null || token.isEmpty) {
      return isAuthRoute ? null : '/login';
    }

    if (isAuthRoute) {
      return '/dashboard';
    }

    return null;
  }
}
