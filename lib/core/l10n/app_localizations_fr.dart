// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'ThinkHub';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navIdeas => 'Idées';

  @override
  String get navProjects => 'Projets';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String get dashboardSubtitle => 'Vue d\'ensemble de vos idées et projets';

  @override
  String get statsTotalIdeas => 'Total idées';

  @override
  String get statsProjects => 'Projets';

  @override
  String get statsInProgress => 'En cours';

  @override
  String get recentIdeas => 'Idées récentes';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get quickActions => 'Actions rapides';

  @override
  String get newIdea => 'Nouvelle idée';

  @override
  String get viewIdeas => 'Voir les idées';

  @override
  String get viewProjects => 'Voir les projets';

  @override
  String get noIdeasYet => 'Aucune idée pour le moment';

  @override
  String get addFirstIdea => 'Ajoutez votre première idée !';

  @override
  String get tapPlusToStart => 'Appuyez sur + pour commencer';

  @override
  String get loadingError => 'Erreur de chargement';

  @override
  String get retry => 'Réessayer';

  @override
  String get ideasTitle => 'Idées';

  @override
  String get deleteIdeaTitle => 'Supprimer cette idée ?';

  @override
  String get deleteIdeaContent => 'Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get ideaDeleted => 'Idée supprimée';

  @override
  String get editIdea => 'Modifier l\'idée';

  @override
  String get newIdeaTitle => 'Nouvelle idée';

  @override
  String get titleLabel => 'Titre';

  @override
  String get titleHint => 'Donnez un titre à votre idée';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Décrivez votre idée en détail...';

  @override
  String get statusLabel => 'Statut';

  @override
  String get save => 'Enregistrer';

  @override
  String get ideaUpdated => 'Idée modifiée avec succès';

  @override
  String get ideaCreated => 'Idée ajoutée avec succès';

  @override
  String get genericError => 'Une erreur est survenue';

  @override
  String get statusIdea => 'Idée';

  @override
  String get statusInProgress => 'En cours';

  @override
  String get statusDone => 'Terminé';

  @override
  String get projectStatusPlanning => 'Planification';

  @override
  String get projectStatusInProgress => 'En cours';

  @override
  String get projectStatusDone => 'Terminé';

  @override
  String get projectsTitle => 'Projets';

  @override
  String get filterAll => 'Tous';

  @override
  String get noProjectsYet => 'Aucun projet pour le moment';

  @override
  String get projectNotFound => 'Projet non trouvé';

  @override
  String get information => 'Informations';

  @override
  String get startDate => 'Date de début';

  @override
  String get endDate => 'Fin prévue';

  @override
  String get linkedIdeas => 'Idées liées';

  @override
  String get noLinkedIdeas => 'Aucune idée liée à ce projet';

  @override
  String ideaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count idées',
      one: '1 idée',
      zero: '0 idée',
    );
    return '$_temp0';
  }

  @override
  String validationRequired(String fieldName) {
    return '$fieldName est requis';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName doit contenir au moins $min caractères';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName ne doit pas dépasser $max caractères';
  }

  @override
  String get fieldTitle => 'Le titre';

  @override
  String get fieldDescription => 'La description';

  @override
  String get fieldDefault => 'Ce champ';

  @override
  String get timeAgoNow => 'à l\'instant';

  @override
  String timeAgoMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count minutes',
      one: 'il y a 1 minute',
    );
    return '$_temp0';
  }

  @override
  String timeAgoHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count heures',
      one: 'il y a 1 heure',
    );
    return '$_temp0';
  }

  @override
  String timeAgoDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count jours',
      one: 'il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String timeAgoMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count mois',
      one: 'il y a 1 mois',
    );
    return '$_temp0';
  }

  @override
  String timeAgoYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count ans',
      one: 'il y a 1 an',
    );
    return '$_temp0';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Fév';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Avr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Juin';

  @override
  String get monthJul => 'Juil';

  @override
  String get monthAug => 'Août';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Déc';
}
