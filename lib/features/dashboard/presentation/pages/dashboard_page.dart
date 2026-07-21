import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/app_drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem-vindo ao ERP Licitai',
                key: const Key('core_dashboard_txt_welcome'),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  key: const Key('core_dashboard_grid_modules'),
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    const _ModuleCard(
                      key: Key('core_dashboard_card_licitacoes'),
                      icon: Icons.gavel,
                      label: 'Licitacoes',
                      color: AppColors.primary,
                    ),
                    const _ModuleCard(
                      key: Key('core_dashboard_card_contratos'),
                      icon: Icons.description,
                      label: 'Contratos',
                      color: AppColors.secondary,
                    ),
                    const _ModuleCard(
                      key: Key('core_dashboard_card_fornecedores'),
                      icon: Icons.business,
                      label: 'Fornecedores',
                      color: Colors.orange,
                    ),
                    const _ModuleCard(
                      key: Key('core_dashboard_card_relatorios'),
                      icon: Icons.bar_chart,
                      label: 'Relatorios',
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: Navigate to module
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
