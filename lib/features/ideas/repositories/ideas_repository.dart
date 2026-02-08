import '../models/idea.dart';

class IdeasRepository {
  final List<Idea> _ideas = [
    Idea(
      id: '1',
      title: 'App de gestion de temps pour freelances',
      description:
          'Une application mobile qui aide les freelances à tracker leur temps de travail par projet, générer des rapports et facturer automatiquement leurs clients.',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      status: 'idea',
    ),
    Idea(
      id: '2',
      title: 'Outil de prise de notes collaboratives',
      description:
          'Un outil web et mobile permettant à une équipe de prendre des notes en temps réel pendant les réunions, avec synchronisation instantanée et historique des modifications.',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      status: 'in_progress',
      projectId: '1',
    ),
    Idea(
      id: '3',
      title: 'App de suivi d\'habitudes avec gamification',
      description:
          'Application qui transforme le suivi d\'habitudes en jeu : points d\'expérience, niveaux, badges et défis hebdomadaires pour rester motivé.',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      status: 'idea',
    ),
    Idea(
      id: '4',
      title: 'Marketplace de services entre voisins',
      description:
          'Plateforme locale pour échanger des services entre voisins : garde d\'animaux, courses, bricolage, jardinage, avec un système de notation.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      status: 'done',
    ),
    Idea(
      id: '5',
      title: 'Dashboard analytics pour réseaux sociaux',
      description:
          'Un tableau de bord unifié qui agrège les statistiques de tous les réseaux sociaux (Instagram, Twitter, LinkedIn) pour les créateurs de contenu.',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      status: 'in_progress',
      projectId: '1',
    ),
    Idea(
      id: '6',
      title: 'App de recettes personnalisées par IA',
      description:
          'Application qui génère des recettes personnalisées en fonction des ingrédients disponibles dans le frigo, des préférences alimentaires et des allergies.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'idea',
    ),
  ];

  int _nextId = 7;

  Future<List<Idea>> getIdeas() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_ideas);
  }

  Future<Idea?> getIdeaById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _ideas.firstWhere((idea) => idea.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Idea>> getIdeasByProjectId(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _ideas.where((idea) => idea.projectId == projectId).toList();
  }

  Future<void> addIdea(Idea idea) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final newIdea = idea.copyWith(id: (_nextId++).toString());
    _ideas.insert(0, newIdea);
  }

  Future<void> updateIdea(Idea idea) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _ideas.indexWhere((i) => i.id == idea.id);
    if (index != -1) {
      _ideas[index] = idea;
    }
  }

  Future<void> deleteIdea(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _ideas.removeWhere((idea) => idea.id == id);
  }
}
