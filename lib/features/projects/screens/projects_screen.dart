import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/constants.dart';
import '../providers/projects_provider.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  String? _statusFilter;

  /// Retourne le label localisé pour un statut de projet
  String _getProjectStatusLabel(AppLocalizations l10n, String statusKey) {
    switch (statusKey) {
      case AppConstants.projectStatusPlanning:
        return l10n.projectStatusPlanning;
      case AppConstants.projectStatusInProgress:
        return l10n.projectStatusInProgress;
      case AppConstants.projectStatusDone:
        return l10n.projectStatusDone;
      default:
        return statusKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projectsState = ref.watch(projectsProvider);

    final projectStatusKeys = [
      AppConstants.projectStatusPlanning,
      AppConstants.projectStatusInProgress,
      AppConstants.projectStatusDone,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.projectsTitle),
      ),
      body: Column(
        children: [
          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: l10n.filterAll,
                    selected: _statusFilter == null,
                    onSelected: () => setState(() => _statusFilter = null),
                  ),
                  const SizedBox(width: 8),
                  ...projectStatusKeys.map(
                    (statusKey) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _FilterChip(
                        label: _getProjectStatusLabel(l10n, statusKey),
                        selected: _statusFilter == statusKey,
                        onSelected: () =>
                            setState(() => _statusFilter = statusKey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Projects list
          Expanded(
            child: projectsState.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48, color: AppTheme.textMuted),
                    const SizedBox(height: 16),
                    Text(
                      l10n.loadingError,
                      style: const TextStyle(color: AppTheme.textBody),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () =>
                          ref.read(projectsProvider.notifier).loadProjects(),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
              data: (projects) {
                final filtered = _statusFilter == null
                    ? projects
                    : projects
                        .where((p) => p.status == _statusFilter)
                        .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppTheme.statsProjectBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.folder_outlined,
                              size: 32, color: AppTheme.statusIdea),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noProjectsYet,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textBody,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 24),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final project = filtered[index];
                    return ProjectCard(
                      key: ValueKey(project.id),
                      project: project,
                      onTap: () => context.go('/projects/${project.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryColor : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppTheme.primaryColor : AppTheme.borderDefault,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(Icons.check, size: 16, color: Colors.white),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? Colors.white : AppTheme.textBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
