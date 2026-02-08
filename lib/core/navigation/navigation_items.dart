import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });
}

const navigationItems = [
  NavigationItem(
    label: 'Dashboard',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    route: '/',
  ),
  NavigationItem(
    label: 'Ideas',
    icon: Icons.lightbulb_outline,
    activeIcon: Icons.lightbulb,
    route: '/ideas',
  ),
  NavigationItem(
    label: 'Projets',
    icon: Icons.folder_outlined,
    activeIcon: Icons.folder,
    route: '/projects',
  ),
];
