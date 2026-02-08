import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/ideas_provider.dart';
import '../widgets/idea_card.dart';

class IdeasScreen extends ConsumerWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasState = ref.watch(ideasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Idées'),
        actions: [
          IconButton(
            onPressed: () => context.go('/ideas/form'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ideasState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: AppTheme.textMuted),
              const SizedBox(height: 16),
              const Text(
                'Erreur de chargement',
                style: TextStyle(color: AppTheme.textBody),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.read(ideasProvider.notifier).loadIdeas(),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
        data: (ideas) {
          if (ideas.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: AppTheme.statsIdeaBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lightbulb_outline,
                        size: 36, color: AppTheme.primaryColor),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ajoutez votre première idée !',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Appuyez sur + pour commencer',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: ideas.length,
            itemBuilder: (context, index) {
              final idea = ideas[index];
              return IdeaCard(
                key: ValueKey(idea.id),
                idea: idea,
                onTap: () => context.go('/ideas/form/${idea.id}'),
                onEdit: () => context.go('/ideas/form/${idea.id}'),
                onDelete: () => _confirmDelete(context, ref, idea.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/ideas/form'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String ideaId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusLg),
        ),
        title: const Text(
          'Supprimer cette idée ?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        content: const Text(
          'Cette action est irréversible.',
          style: TextStyle(color: AppTheme.textBody),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              ref.read(ideasProvider.notifier).deleteIdea(ideaId);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Idée supprimée')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.deleteIcon),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
