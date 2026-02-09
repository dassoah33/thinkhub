import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';
import '../../../utils/validators.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../models/idea.dart';
import '../providers/ideas_provider.dart';

class IdeaFormScreen extends ConsumerStatefulWidget {
  final String? ideaId;

  const IdeaFormScreen({super.key, this.ideaId});

  @override
  ConsumerState<IdeaFormScreen> createState() => _IdeaFormScreenState();
}

class _IdeaFormScreenState extends ConsumerState<IdeaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String _status = AppConstants.statusIdea;
  bool _isLoading = false;
  bool _isEditMode = false;
  Idea? _existingIdea;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _isEditMode = widget.ideaId != null;

    if (_isEditMode) {
      _loadIdea();
    }
  }

  void _loadIdea() {
    final ideasState = ref.read(ideasProvider);
    ideasState.whenData((ideas) {
      try {
        final idea = ideas.firstWhere((i) => i.id == widget.ideaId);
        _existingIdea = idea;
        _titleController.text = idea.title;
        _descriptionController.text = idea.description;
        setState(() {
          _status = idea.status;
        });
      } catch (_) {
        // Idea not found
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Retourne le label localisé pour un statut d'idée
  String _getIdeaStatusLabel(AppLocalizations l10n, String statusKey) {
    switch (statusKey) {
      case AppConstants.statusIdea:
        return l10n.statusIdea;
      case AppConstants.statusInProgress:
        return l10n.statusInProgress;
      case AppConstants.statusDone:
        return l10n.statusDone;
      default:
        return statusKey;
    }
  }

  Future<void> _saveIdea() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      if (_isEditMode && _existingIdea != null) {
        final updatedIdea = _existingIdea!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          status: _status,
        );
        await ref.read(ideasProvider.notifier).updateIdea(updatedIdea);
      } else {
        await ref.read(ideasProvider.notifier).addIdea(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              status: _status,
            );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode ? l10n.ideaUpdated : l10n.ideaCreated,
            ),
          ),
        );
        context.go('/ideas');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.genericError)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Liste des statuts avec leurs labels localisés
    final statusEntries = [
      AppConstants.statusIdea,
      AppConstants.statusInProgress,
      AppConstants.statusDone,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? l10n.editIdea : l10n.newIdeaTitle),
        leading: IconButton(
          onPressed: () => context.go('/ideas'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _titleController,
                label: l10n.titleLabel,
                hint: l10n.titleHint,
                autofocus: !_isEditMode,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    Validators.required(context, value, fieldName: l10n.fieldTitle),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _descriptionController,
                label: l10n.descriptionLabel,
                hint: l10n.descriptionHint,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                validator: (value) =>
                    Validators.required(context, value, fieldName: l10n.fieldDescription),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.statusLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(),
                items: statusEntries
                    .map(
                      (statusKey) => DropdownMenuItem(
                        value: statusKey,
                        child: Text(_getIdeaStatusLabel(l10n, statusKey)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _status = value);
                  }
                },
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: l10n.save,
                icon: Icons.save_outlined,
                onPressed: _saveIdea,
                isLoading: _isLoading,
                expand: true,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => context.go('/ideas'),
                  child: Text(l10n.cancel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
