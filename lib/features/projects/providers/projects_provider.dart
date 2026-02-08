import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project.dart';
import '../repositories/projects_repository.dart';

final projectsRepositoryProvider = Provider<ProjectsRepository>((ref) {
  return ProjectsRepository();
});

final projectsProvider =
    StateNotifierProvider<ProjectsNotifier, AsyncValue<List<Project>>>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return ProjectsNotifier(repository);
});

class ProjectsNotifier extends StateNotifier<AsyncValue<List<Project>>> {
  final ProjectsRepository _repository;

  ProjectsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProjects();
  }

  Future<void> loadProjects() async {
    state = const AsyncValue.loading();
    try {
      final projects = await _repository.getProjects();
      state = AsyncValue.data(projects);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addProject({
    required String title,
    required String description,
    DateTime? endDate,
  }) async {
    final project = Project(
      id: '',
      title: title,
      description: description,
      createdAt: DateTime.now(),
      endDate: endDate,
    );
    await _repository.addProject(project);
    await loadProjects();
  }

  Future<void> updateProject(Project project) async {
    await _repository.updateProject(project);
    await loadProjects();
  }

  Future<void> deleteProject(String id) async {
    await _repository.deleteProject(id);
    await loadProjects();
  }
}

final projectByIdProvider =
    FutureProvider.family<Project?, String>((ref, id) async {
  final repository = ref.watch(projectsRepositoryProvider);
  return repository.getProjectById(id);
});
