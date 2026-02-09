import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';

class Validators {
  Validators._();

  static String? required(BuildContext context, String? value, {String? fieldName}) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequired(fieldName ?? l10n.fieldDefault);
    }
    return null;
  }

  static String? minLength(BuildContext context, String? value, int min, {String? fieldName}) {
    final l10n = AppLocalizations.of(context)!;
    if (value == null || value.trim().length < min) {
      return l10n.validationMinLength(fieldName ?? l10n.fieldDefault, min);
    }
    return null;
  }

  static String? maxLength(BuildContext context, String? value, int max, {String? fieldName}) {
    final l10n = AppLocalizations.of(context)!;
    if (value != null && value.trim().length > max) {
      return l10n.validationMaxLength(fieldName ?? l10n.fieldDefault, max);
    }
    return null;
  }

  /// Combine plusieurs validateurs en un seul
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
