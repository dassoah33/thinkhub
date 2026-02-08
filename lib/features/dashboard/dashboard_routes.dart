import 'package:go_router/go_router.dart';

import 'screens/dashboard_screen.dart';

class DashboardRoutes {
  static final routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
  ];
}
