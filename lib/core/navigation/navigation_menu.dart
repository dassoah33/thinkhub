import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.go(navigationItems[index].route),
        items: navigationItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                activeIcon: Icon(item.activeIcon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
