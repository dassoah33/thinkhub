import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider pour l'instance SharedPreferences.
/// Doit être overridé dans ProviderScope avec l'instance pré-initialisée.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope',
  );
});

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static const String _localeKey = 'app_locale';
  static const String _defaultLocale = 'fr';

  /// Lit le code langue sauvegardé. Retourne 'fr' par défaut.
  String getLocale() {
    return _prefs.getString(_localeKey) ?? _defaultLocale;
  }

  /// Persiste le code langue sélectionné.
  Future<void> setLocale(String languageCode) async {
    await _prefs.setString(_localeKey, languageCode);
  }
}

/// Provider pour StorageService, dépend de sharedPreferencesProvider.
final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return StorageService(prefs);
});
