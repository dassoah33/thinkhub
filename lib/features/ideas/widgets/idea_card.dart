import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';

import '../../../core/theme/app_theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/formatters.dart';
import '../models/idea.dart';

class IdeaCard extends StatelessWidget {
  final Idea idea;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const IdeaCard({
    super.key,
    required this.idea,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  Color _statusBgColor() {
    switch (idea.status) {
      case 'in_progress':
        return AppTheme.statusInProgressBg;
      case 'done':
        return AppTheme.statusDoneBg;
      default:
        return AppTheme.statusIdeaBg;
    }
  }

  Color _statusTextColor() {
    switch (idea.status) {
      case 'in_progress':
        return AppTheme.statusInProgressText;
      case 'done':
        return AppTheme.statusDoneText;
      default:
        return AppTheme.statusIdeaText;
    }
  }

  IconData _statusIcon() {
    switch (idea.status) {
      case 'in_progress':
        return Icons.play_circle_outline;
      case 'done':
        return Icons.check_circle_outline;
      default:
        return Icons.lightbulb_outline;
    }
  }

  /// Retourne le label localisé pour un statut d'idée
  String _getIdeaStatusLabel(AppLocalizations l10n, String statusKey) {
    switch (statusKey) {
      case AppConstants.statusIdea:
        return l10n.statusIdea;
      case AppConstants.statusInProgress:
        return l10n.statusInProgress;
      case AppConstants.statusDone:
        return l10n.statusDone;
      default:
        return statusKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusLabel = _getIdeaStatusLabel(l10n, idea.status);

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
                // Title + status badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        idea.title,
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
                  idea.description,
                  maxLines: AppConstants.descriptionMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textBody,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Footer: date + actions
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppTheme.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        Formatters.timeAgo(context, idea.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      const Spacer(),
                      if (onEdit != null)
                        _ActionIcon(
                          icon: Icons.edit_outlined,
                          color: AppTheme.editIcon,
                          onTap: onEdit!,
                        ),
                      if (onDelete != null) ...[
                        const SizedBox(width: 4),
                        _ActionIcon(
                          icon: Icons.delete_outline,
                          color: AppTheme.deleteIcon,
                          onTap: onDelete!,
                        ),
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
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }
}
