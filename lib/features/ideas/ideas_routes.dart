import 'package:go_router/go_router.dart';

import 'screens/idea_form_screen.dart';
import 'screens/ideas_screen.dart';

class IdeasRoutes {
  static final routes = [
    GoRoute(
      path: '/ideas',
      builder: (context, state) => const IdeasScreen(),
    ),
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
  ];
}
