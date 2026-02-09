import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/locale_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/formatters.dart';
import '../../ideas/providers/ideas_provider.dart';
import '../../projects/providers/projects_provider.dart';
import '../widgets/stats_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _getGreeting(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 18) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ideasState = ref.watch(ideasProvider);
    final projectsState = ref.watch(projectsProvider);
    final isDesktop =
        MediaQuery.of(context).size.width > AppConstants.mobileBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lightbulb_rounded,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text('ThinkHub'),
          ],
        ),
        actions: const [
          _LanguageSwitcher(),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              '${_getGreeting(context)} !',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.dashboardSubtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textBody,
              ),
            ),
            const SizedBox(height: 24),

            // Stats
            _buildStats(context, ideasState, projectsState, isDesktop),

            const SizedBox(height: 32),

            // Recent ideas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.recentIdeas,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/ideas'),
                  child: Text(l10n.viewAll),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildRecentIdeas(context, ideasState),

            const SizedBox(height: 32),

            // Quick actions
            Text(
              l10n.quickActions,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildQuickActions(context, isDesktop),

            const SizedBox(height: 24),
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
    final l10n = AppLocalizations.of(context)!;

    final ideaCount = ideasState.whenOrNull(
          data: (ideas) => (ideas as List).length,
        ) ??
        0;

    final projectCount = projectsState.whenOrNull(
          data: (projects) => (projects as List).length,
        ) ??
        0;

    final inProgressCount = projectsState.whenOrNull(
          data: (projects) => (projects as List)
              .where((p) => p.status == AppConstants.projectStatusInProgress)
              .length,
        ) ??
        0;

    final children = [
      StatsCard(
        title: l10n.statsTotalIdeas,
        value: ideaCount.toString(),
        icon: Icons.lightbulb_rounded,
        color: AppTheme.primaryColor,
        backgroundColor: AppTheme.statsIdeaBg,
        gradient: AppTheme.ideaGradient,
      ),
      StatsCard(
        title: l10n.statsProjects,
        value: projectCount.toString(),
        icon: Icons.folder_rounded,
        color: const Color(0xFF3B82F6),
        backgroundColor: AppTheme.statsProjectBg,
        gradient: AppTheme.projectGradient,
      ),
      StatsCard(
        title: l10n.statsInProgress,
        value: inProgressCount.toString(),
        icon: Icons.trending_up_rounded,
        color: AppTheme.statusInProgress,
        backgroundColor: AppTheme.statsInProgressBg,
        gradient: AppTheme.progressGradient,
      ),
    ];

    return Row(
      children: children
          .map((card) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: card,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildRecentIdeas(BuildContext context, AsyncValue ideasState) {
    final l10n = AppLocalizations.of(context)!;

    return ideasState.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, _) => Text(l10n.loadingError),
      data: (ideas) {
        final recentIdeas =
            (ideas as List).take(AppConstants.recentIdeasCount).toList();
        if (recentIdeas.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Center(
              child: Text(
                l10n.noIdeasYet,
                style: const TextStyle(color: AppTheme.textMuted),
              ),
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Column(
            children: recentIdeas.asMap().entries.map((entry) {
              final index = entry.key;
              final idea = entry.value;
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.go('/ideas/form/${idea.id}'),
                      borderRadius: BorderRadius.vertical(
                        top: index == 0
                            ? const Radius.circular(AppTheme.borderRadiusLg)
                            : Radius.zero,
                        bottom: index == recentIdeas.length - 1
                            ? const Radius.circular(AppTheme.borderRadiusLg)
                            : Radius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            // Colored icon with subtle gradient
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _ideaStatusBg(idea.status),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _ideaStatusIconColor(idea.status)
                                      .withValues(alpha: 0.15),
                                ),
                              ),
                              child: Icon(
                                _ideaStatusIcon(idea.status),
                                color: _ideaStatusIconColor(idea.status),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    idea.title,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    idea.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.textBody,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    Formatters.timeAgo(context, idea.createdAt),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppTheme.textMuted,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (index < recentIdeas.length - 1)
                    Divider(
                      height: 1,
                      indent: 70,
                      color: AppTheme.borderLight,
                    ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Color _ideaStatusBg(String status) {
    switch (status) {
      case 'in_progress':
        return AppTheme.statusInProgressBg;
      case 'done':
        return AppTheme.statusDoneBg;
      default:
        return AppTheme.statusIdeaBg;
    }
  }

  Color _ideaStatusIconColor(String status) {
    switch (status) {
      case 'in_progress':
        return AppTheme.statusInProgress;
      case 'done':
        return AppTheme.statusDone;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _ideaStatusIcon(String status) {
    switch (status) {
      case 'in_progress':
        return Icons.play_circle_outline;
      case 'done':
        return Icons.check_circle_outline;
      default:
        return Icons.lightbulb_outline;
    }
  }

  Widget _buildQuickActions(BuildContext context, bool isDesktop) {
    final l10n = AppLocalizations.of(context)!;

    final actions = [
      _QuickAction(
        icon: Icons.add_rounded,
        label: l10n.newIdea,
        color: AppTheme.primaryColor,
        bgColor: AppTheme.statsIdeaBg,
        onTap: () => context.go('/ideas/form'),
      ),
      _QuickAction(
        icon: Icons.lightbulb_outline,
        label: l10n.viewIdeas,
        color: AppTheme.statusIdea,
        bgColor: AppTheme.statusIdeaBg,
        onTap: () => context.go('/ideas'),
      ),
      _QuickAction(
        icon: Icons.folder_outlined,
        label: l10n.viewProjects,
        color: AppTheme.statusInProgress,
        bgColor: AppTheme.statsInProgressBg,
        onTap: () => context.go('/projects'),
      ),
    ];

    if (isDesktop) {
      return Row(
        children: actions
            .map((action) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: action,
                  ),
                ))
            .toList(),
      );
    }

    return Column(
      children: actions
          .map((action) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: action,
              ))
          .toList(),
    );
  }
}

class _LanguageSwitcher extends ConsumerWidget {
  const _LanguageSwitcher();

  static const _languages = [
    _LanguageOption(locale: Locale('fr'), flag: '🇫🇷', label: 'Français'),
    _LanguageOption(locale: Locale('en'), flag: '🇬🇧', label: 'English'),
    _LanguageOption(locale: Locale('es'), flag: '🇪🇸', label: 'Español'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    final currentFlag = _languages
        .firstWhere(
          (l) => l.locale.languageCode == currentLocale.languageCode,
          orElse: () => _languages.first,
        )
        .flag;

    return PopupMenuButton<Locale>(
      tooltip: 'Language',
      offset: const Offset(0, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      icon: Text(currentFlag, style: const TextStyle(fontSize: 22)),
      onSelected: (locale) {
        ref.read(localeProvider.notifier).setLocale(locale);
      },
      itemBuilder: (context) => _languages.map((lang) {
        final isSelected =
            lang.locale.languageCode == currentLocale.languageCode;
        return PopupMenuItem<Locale>(
          value: lang.locale,
          child: Row(
            children: [
              Text(lang.flag, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  lang.label,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.textPrimary,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_rounded,
                    color: AppTheme.primaryColor, size: 20),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _LanguageOption {
  final Locale locale;
  final String flag;
  final String label;

  const _LanguageOption({
    required this.locale,
    required this.flag,
    required this.label,
  });
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded,
                    color: AppTheme.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
