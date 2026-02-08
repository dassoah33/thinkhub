import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/idea.dart';
import '../repositories/ideas_repository.dart';

/// Fournit l'instance unique du repository
final ideasRepositoryProvider = Provider<IdeasRepository>((ref) {
  return IdeasRepository();
});

/// Gère l'état de la liste des idées
final ideasProvider =
    StateNotifierProvider<IdeasNotifier, AsyncValue<List<Idea>>>((ref) {
  final repository = ref.watch(ideasRepositoryProvider);
  return IdeasNotifier(repository);
});

class IdeasNotifier extends StateNotifier<AsyncValue<List<Idea>>> {
  final IdeasRepository _repository;

  IdeasNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadIdeas();
  }

  Future<void> loadIdeas() async {
    state = const AsyncValue.loading();
    try {
      final ideas = await _repository.getIdeas();
      state = AsyncValue.data(ideas);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addIdea({
    required String title,
    required String description,
    String status = 'idea',
  }) async {
    final idea = Idea(
      id: '',
      title: title,
      description: description,
      createdAt: DateTime.now(),
      status: status,
    );
    await _repository.addIdea(idea);
    await loadIdeas();
  }

  Future<void> updateIdea(Idea idea) async {
    await _repository.updateIdea(idea);
    await loadIdeas();
  }

  Future<void> deleteIdea(String id) async {
    await _repository.deleteIdea(id);
    await loadIdeas();
  }
}

/// Fournit les idées liées à un projet spécifique
final ideasByProjectProvider =
    FutureProvider.family<List<Idea>, String>((ref, projectId) async {
  final repository = ref.watch(ideasRepositoryProvider);
  return repository.getIdeasByProjectId(projectId);
});
