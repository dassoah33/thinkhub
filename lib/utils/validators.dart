class Validators {
  Validators._();

  static String? required(String? value, {String fieldName = 'Ce champ'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  static String? minLength(String? value, int min, {String fieldName = 'Ce champ'}) {
    if (value == null || value.trim().length < min) {
      return '$fieldName doit contenir au moins $min caractères';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String fieldName = 'Ce champ'}) {
    if (value != null && value.trim().length > max) {
      return '$fieldName ne doit pas dépasser $max caractères';
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
