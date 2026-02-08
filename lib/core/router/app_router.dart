import 'package:go_router/go_router.dart';

import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/ideas/screens/idea_form_screen.dart';
import '../../features/ideas/screens/ideas_screen.dart';
import '../../features/projects/screens/project_detail_screen.dart';
import '../../features/projects/screens/projects_screen.dart';
import '../navigation/navigation_menu.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Routes avec bottom navigation bar
    ShellRoute(
      builder: (context, state, child) => NavigationMenu(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/ideas',
          builder: (context, state) => const IdeasScreen(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsScreen(),
        ),
      ],
    ),
    // Routes sans bottom navigation bar
    GoRoute(
      path: '/ideas/form',
      builder: (context, state) => const IdeaFormScreen(),
    ),
    GoRoute(
      path: '/ideas/form/:id',
      builder: (context, state) => IdeaFormScreen(
        ideaId: state.pathParameters['id'],
      ),
    ),
    GoRoute(
      path: '/projects/:id',
      builder: (context, state) => ProjectDetailScreen(
        projectId: state.pathParameters['id']!,
      ),
    ),
  ],
);
