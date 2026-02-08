class AppConstants {
  AppConstants._();

  static const String appName = 'ThinkHub';

  // Statuts des idées
  static const String statusIdea = 'idea';
  static const String statusInProgress = 'in_progress';
  static const String statusDone = 'done';

  // Statuts des projets
  static const String projectStatusPlanning = 'planning';
  static const String projectStatusInProgress = 'in_progress';
  static const String projectStatusDone = 'done';

  // Labels affichés pour les statuts
  static const Map<String, String> ideaStatusLabels = {
    statusIdea: 'Idée',
    statusInProgress: 'En cours',
    statusDone: 'Terminé',
  };

  static const Map<String, String> projectStatusLabels = {
    projectStatusPlanning: 'Planification',
    projectStatusInProgress: 'En cours',
    projectStatusDone: 'Terminé',
  };

  // Breakpoints responsive
  static const double mobileBreakpoint = 600;

  // Limites
  static const int recentIdeasCount = 3;
  static const int descriptionMaxLines = 2;
}
