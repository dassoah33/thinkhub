import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/constants.dart';
import '../../ideas/providers/ideas_provider.dart';
import '../../projects/providers/projects_provider.dart';
import '../widgets/stats_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasState = ref.watch(ideasProvider);
    final projectsState = ref.watch(projectsProvider);
    final isDesktop = MediaQuery.of(context).size.width > AppConstants.mobileBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lightbulb, color: AppTheme.primaryColor, size: 24),
            const SizedBox(width: 8),
            const Text('ThinkHub'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tableau de bord',
              style: TextStyle(
                fontSize: isDesktop ? 28 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Vue d\'ensemble de vos idées et projets',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),

            // Statistiques
            _buildStats(context, ideasState, projectsState, isDesktop),

            const SizedBox(height: 32),

            // Idées récentes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Idées récentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/ideas'),
                  child: const Text('Voir tout'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildRecentIdeas(context, ideasState),

            const SizedBox(height: 32),

            // Actions rapides
            const Text(
              'Actions rapides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildQuickActions(context, isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(
    BuildContext context,
    AsyncValue ideasState,
    AsyncValue projectsState,
    bool isDesktop,
  ) {
    final ideaCount = ideasState.whenOrNull(
      data: (ideas) => (ideas as List).length,
    ) ?? 0;

    final projectCount = projectsState.whenOrNull(
      data: (projects) => (projects as List).length,
    ) ?? 0;

    final inProgressCount = projectsState.whenOrNull(
      data: (projects) => (projects as List)
          .where((p) => p.status == AppConstants.projectStatusInProgress)
          .length,
    ) ?? 0;

    final children = [
      StatsCard(
        title: 'Total idées',
        value: ideaCount.toString(),
        icon: Icons.lightbulb_outline,
        color: AppTheme.primaryColor,
      ),
      StatsCard(
        title: 'Projets',
        value: projectCount.toString(),
        icon: Icons.folder_outlined,
        color: AppTheme.secondaryColor,
      ),
      StatsCard(
        title: 'En cours',
        value: inProgressCount.toString(),
        icon: Icons.trending_up,
        color: AppTheme.statusInProgress,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: children
            .map((card) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: card,
                  ),
                ))
            .toList(),
      );
    }

    return Column(children: children);
  }

  Widget _buildRecentIdeas(BuildContext context, AsyncValue ideasState) {
    return ideasState.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, _) => const Text('Erreur de chargement'),
      data: (ideas) {
        final recentIdeas = (ideas as List).take(AppConstants.recentIdeasCount).toList();
        if (recentIdeas.isEmpty) {
          return Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Aucune idée pour le moment',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          );
        }

        return Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: recentIdeas.asMap().entries.map((entry) {
              final index = entry.key;
              final idea = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.lightbulb_outline,
                      color: AppTheme.primaryColor,
                    ),
                    title: Text(
                      idea.title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      idea.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go('/ideas/form/${idea.id}'),
                  ),
                  if (index < recentIdeas.length - 1) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDesktop) {
    final actions = [
      _QuickAction(
        icon: Icons.add,
        label: 'Nouvelle idée',
        color: AppTheme.primaryColor,
        onTap: () => context.go('/ideas/form'),
      ),
      _QuickAction(
        icon: Icons.lightbulb_outline,
        label: 'Voir les idées',
        color: AppTheme.secondaryColor,
        onTap: () => context.go('/ideas'),
      ),
      _QuickAction(
        icon: Icons.folder_outlined,
        label: 'Voir les projets',
        color: AppTheme.statusInProgress,
        onTap: () => context.go('/projects'),
      ),
    ];

    if (isDesktop) {
      return Row(
        children: actions
            .map((action) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: action,
                  ),
                ))
            .toList(),
      );
    }

    return Column(
      children: actions.map((action) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: action,
      )).toList(),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
