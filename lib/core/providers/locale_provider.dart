import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/local/storage_service.dart';

/// Provider de la locale courante, persistée via StorageService.
final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return LocaleNotifier(storageService);
});

class LocaleNotifier extends StateNotifier<Locale> {
  final StorageService _storageService;

  LocaleNotifier(this._storageService)
      : super(Locale(_storageService.getLocale()));

  /// Change la locale de l'app et persiste le choix.
  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _storageService.setLocale(locale.languageCode);
  }
}
