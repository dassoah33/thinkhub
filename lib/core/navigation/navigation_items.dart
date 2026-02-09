import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';

class NavigationItem {
  final String Function(AppLocalizations l10n) labelBuilder;
  final IconData icon;
  final IconData activeIcon;
  final String route;

  const NavigationItem({
    required this.labelBuilder,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  String getLabel(AppLocalizations l10n) => labelBuilder(l10n);
}

final navigationItems = [
  NavigationItem(
    labelBuilder: (l10n) => l10n.navDashboard,
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    route: '/',
  ),
  NavigationItem(
    labelBuilder: (l10n) => l10n.navIdeas,
    icon: Icons.lightbulb_outline,
    activeIcon: Icons.lightbulb,
    route: '/ideas',
  ),
  NavigationItem(
    labelBuilder: (l10n) => l10n.navProjects,
    icon: Icons.folder_outlined,
    activeIcon: Icons.folder,
    route: '/projects',
  ),
];
