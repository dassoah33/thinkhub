import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/formatters.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  Color _statusBgColor() {
    switch (project.status) {
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

  Color _statusTextColor() {
    switch (project.status) {
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

  IconData _statusIcon() {
    switch (project.status) {
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
  Widget build(BuildContext context) {
    final statusLabel =
        AppConstants.projectStatusLabels[project.status] ?? project.status;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row with badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _statusBgColor(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _statusIcon(),
                            size: 14,
                            color: _statusTextColor(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            statusLabel,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _statusTextColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Description
                Text(
                  project.description,
                  maxLines: AppConstants.descriptionMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textBody,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Footer with date, ideas count, progress
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: AppTheme.textMuted,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            Formatters.formatDateShort(project.createdAt),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          if (project.ideaIds.isNotEmpty) ...[
                            const SizedBox(width: 16),
                            Icon(
                              Icons.lightbulb_outline,
                              size: 14,
                              color: AppTheme.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${project.ideaIds.length} idée${project.ideaIds.length > 1 ? 's' : ''}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ],
                      ),
                      // Progress bar for in-progress projects
                      if (project.status == 'in_progress') ...[
                        const SizedBox(height: 10),
                        _ProgressBar(progress: _calculateProgress()),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateProgress() {
    if (project.endDate == null) return 0.5;
    final total =
        project.endDate!.difference(project.createdAt).inDays.toDouble();
    if (total <= 0) return 1.0;
    final elapsed =
        DateTime.now().difference(project.createdAt).inDays.toDouble();
    return (elapsed / total).clamp(0.0, 1.0);
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;

  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toInt();
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.borderLight,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$percent%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }
}
