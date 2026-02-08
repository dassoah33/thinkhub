import '../models/project.dart';

class ProjectsRepository {
  final List<Project> _projects = [
    Project(
      id: '1',
      title: 'ThinkHub - App de gestion d\'idées',
      description:
          'Application mobile de gestion d\'idées et de projets pour l\'équipe Lyzanpro. Permet de centraliser les idées, les organiser en projets et suivre leur avancement. Développée avec Flutter et Riverpod.',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 60)),
      status: 'in_progress',
      ideaIds: ['2', '5'],
    ),
    Project(
      id: '2',
      title: 'Portfolio personnel',
      description:
          'Site web portfolio responsive pour présenter les projets de l\'équipe. Inclut une galerie de projets, une page à propos et un formulaire de contact. Développé avec Flutter Web.',
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      endDate: DateTime.now().subtract(const Duration(days: 10)),
      status: 'done',
      ideaIds: [],
    ),
    Project(
      id: '3',
      title: 'API de gestion de tâches',
      description:
          'Backend REST API pour un système de gestion de tâches collaboratif. Authentification JWT, CRUD complet, notifications en temps réel via WebSocket.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      status: 'planning',
      ideaIds: [],
    ),
  ];

  int _nextId = 4;

  Future<List<Project>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_projects);
  }

  Future<Project?> getProjectById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _projects.firstWhere((project) => project.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> addProject(Project project) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newProject = project.copyWith(id: (_nextId++).toString());
    _projects.insert(0, newProject);
  }

  Future<void> updateProject(Project project) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    }
  }

  Future<void> deleteProject(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _projects.removeWhere((project) => project.id == id);
  }
}
