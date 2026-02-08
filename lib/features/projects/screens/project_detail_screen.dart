import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/formatters.dart';
import '../../ideas/providers/ideas_provider.dart';
import '../../ideas/widgets/idea_card.dart';
import '../providers/projects_provider.dart';

class ProjectDetailScreen extends ConsumerWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  Color _statusBgColor(String status) {
    switch (status) {
      case 'in_progress':
        return AppTheme.statusInProgressBg;
      case 'done':
        return AppTheme.statusDoneBg;
      case 'planning':
        return AppTheme.statusPlanningBg;
      default:
        return AppTheme.statusIdeaBg;
    }
  }

  Color _statusTextColor(String status) {
    switch (status) {
      case 'in_progress':
        return AppTheme.statusInProgressText;
      case 'done':
        return AppTheme.statusDoneText;
      case 'planning':
        return AppTheme.statusPlanningText;
      default:
        return AppTheme.statusIdeaText;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'in_progress':
        return Icons.play_circle_outline;
      case 'done':
        return Icons.check_circle_outline;
      case 'planning':
        return Icons.schedule_outlined;
      default:
        return Icons.lightbulb_outline;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectByIdProvider(projectId));
    final linkedIdeasAsync = ref.watch(ideasByProjectProvider(projectId));

    return projectAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Erreur de chargement')),
      ),
      data: (project) {
        if (project == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Projet non trouvé')),
          );
        }

        final statusLabel =
            AppConstants.projectStatusLabels[project.status] ?? project.status;

        return Scaffold(
          appBar: AppBar(
            title: Text(project.title),
            leading: IconButton(
              onPressed: () => context.go('/projects'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Information card
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius:
                        BorderRadius.circular(AppTheme.borderRadiusLg),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppTheme.statsProjectBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.info_outline,
                                  size: 18, color: AppTheme.statusIdea),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Informations',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: _statusBgColor(project.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _statusIcon(project.status),
                                    size: 14,
                                    color: _statusTextColor(project.status),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    statusLabel,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _statusTextColor(project.status),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          project.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textBody,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: AppTheme.borderLight),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Date de début',
                          value: Formatters.formatDate(project.createdAt),
                        ),
                        if (project.endDate != null) ...[
                          const SizedBox(height: 10),
                          _InfoRow(
                            icon: Icons.event_outlined,
                            label: 'Fin prévue',
                            value: Formatters.formatDate(project.endDate!),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Linked ideas section
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.statsIdeaBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.lightbulb_outline,
                          size: 18, color: AppTheme.primaryColor),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Idées liées',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                linkedIdeasAsync.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, _) => const Text('Erreur de chargement'),
                  data: (ideas) {
                    if (ideas.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(
                              AppTheme.borderRadiusLg),
                          boxShadow: AppTheme.cardShadow,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: AppTheme.statsIdeaBg,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.lightbulb_outline,
                                    size: 24, color: AppTheme.textMuted),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Aucune idée liée à ce projet',
                                style: TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: ideas
                          .map(
                            (idea) => IdeaCard(
                              idea: idea,
                              onTap: () =>
                                  context.go('/ideas/form/${idea.id}'),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textMuted),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.textMuted,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
