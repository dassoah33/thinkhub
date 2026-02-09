import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import 'navigation_items.dart';

class NavigationMenu extends StatelessWidget {
  final Widget child;

  const NavigationMenu({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (int i = 0; i < navigationItems.length; i++) {
      if (location == navigationItems[i].route) return i;
      if (i > 0 && location.startsWith(navigationItems[i].route)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          boxShadow: AppTheme.navShadow,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navigationItems.length, (index) {
                final item = navigationItems[index];
                final isActive = index == currentIndex;
                return _NavItem(
                  icon: isActive ? item.activeIcon : item.icon,
                  label: item.getLabel(l10n),
                  isActive: isActive,
                  onTap: () => context.go(item.route),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active indicator bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: isActive ? 24 : 0,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
            Icon(
              icon,
              size: isActive ? 26 : 24,
              color: isActive ? AppTheme.primaryColor : AppTheme.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppTheme.primaryColor : AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
