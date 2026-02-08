import 'package:go_router/go_router.dart';

import 'screens/project_detail_screen.dart';
import 'screens/projects_screen.dart';

class ProjectsRoutes {
  static final routes = [
    GoRoute(
      path: '/projects',
      builder: (context, state) => const ProjectsScreen(),
    ),
    GoRoute(
      path: '/projects/:id',
      builder: (context, state) => ProjectDetailScreen(
        projectId: state.pathParameters['id']!,
      ),
    ),
  ];
}
