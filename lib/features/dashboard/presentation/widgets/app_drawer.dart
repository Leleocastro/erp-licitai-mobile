import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final userName = authState is AuthAuthenticated ? authState.user.name : 'Usuario';

    return Drawer(
      key: const Key('app_drawer'),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 8),
                Text(
                  userName,
                  key: const Key('header_user_name'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            key: const Key('drawer_item_dashboard'),
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              context.go('/dashboard');
            },
          ),
          ListTile(
            key: const Key('drawer_item_usuarios'),
            leading: const Icon(Icons.people),
            title: const Text('Usuarios'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to usuarios
            },
          ),
          ListTile(
            key: const Key('drawer_item_orgaos'),
            leading: const Icon(Icons.account_balance),
            title: const Text('Orgaos'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to orgaos
            },
          ),
          ListTile(
            key: const Key('drawer_item_roles'),
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Roles'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to roles
            },
          ),
          const Divider(),
          ListTile(
            key: const Key('drawer_item_auditoria'),
            leading: const Icon(Icons.history),
            title: const Text('Auditoria'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to auditoria
            },
          ),
          const Divider(),
          ListTile(
            key: const Key('drawer_item_logout'),
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () {
              context.read<AuthBloc>().add(const AuthLogoutRequested());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
