import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'ThinkHub'**
  String get appTitle;

  /// No description provided for @navDashboard.
  ///
  /// In fr, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navIdeas.
  ///
  /// In fr, this message translates to:
  /// **'Idées'**
  String get navIdeas;

  /// No description provided for @navProjects.
  ///
  /// In fr, this message translates to:
  /// **'Projets'**
  String get navProjects;

  /// No description provided for @greetingMorning.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In fr, this message translates to:
  /// **'Bon après-midi'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In fr, this message translates to:
  /// **'Bonsoir'**
  String get greetingEvening;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Vue d\'ensemble de vos idées et projets'**
  String get dashboardSubtitle;

  /// No description provided for @statsTotalIdeas.
  ///
  /// In fr, this message translates to:
  /// **'Total idées'**
  String get statsTotalIdeas;

  /// No description provided for @statsProjects.
  ///
  /// In fr, this message translates to:
  /// **'Projets'**
  String get statsProjects;

  /// No description provided for @statsInProgress.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get statsInProgress;

  /// No description provided for @recentIdeas.
  ///
  /// In fr, this message translates to:
  /// **'Idées récentes'**
  String get recentIdeas;

  /// No description provided for @viewAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir tout'**
  String get viewAll;

  /// No description provided for @quickActions.
  ///
  /// In fr, this message translates to:
  /// **'Actions rapides'**
  String get quickActions;

  /// No description provided for @newIdea.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle idée'**
  String get newIdea;

  /// No description provided for @viewIdeas.
  ///
  /// In fr, this message translates to:
  /// **'Voir les idées'**
  String get viewIdeas;

  /// No description provided for @viewProjects.
  ///
  /// In fr, this message translates to:
  /// **'Voir les projets'**
  String get viewProjects;

  /// No description provided for @noIdeasYet.
  ///
  /// In fr, this message translates to:
  /// **'Aucune idée pour le moment'**
  String get noIdeasYet;

  /// No description provided for @addFirstIdea.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez votre première idée !'**
  String get addFirstIdea;

  /// No description provided for @tapPlusToStart.
  ///
  /// In fr, this message translates to:
  /// **'Appuyez sur + pour commencer'**
  String get tapPlusToStart;

  /// No description provided for @loadingError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de chargement'**
  String get loadingError;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @ideasTitle.
  ///
  /// In fr, this message translates to:
  /// **'Idées'**
  String get ideasTitle;

  /// No description provided for @deleteIdeaTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cette idée ?'**
  String get deleteIdeaTitle;

  /// No description provided for @deleteIdeaContent.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible.'**
  String get deleteIdeaContent;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @ideaDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Idée supprimée'**
  String get ideaDeleted;

  /// No description provided for @editIdea.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'idée'**
  String get editIdea;

  /// No description provided for @newIdeaTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle idée'**
  String get newIdeaTitle;

  /// No description provided for @titleLabel.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get titleLabel;

  /// No description provided for @titleHint.
  ///
  /// In fr, this message translates to:
  /// **'Donnez un titre à votre idée'**
  String get titleHint;

  /// No description provided for @descriptionLabel.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez votre idée en détail...'**
  String get descriptionHint;

  /// No description provided for @statusLabel.
  ///
  /// In fr, this message translates to:
  /// **'Statut'**
  String get statusLabel;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @ideaUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Idée modifiée avec succès'**
  String get ideaUpdated;

  /// No description provided for @ideaCreated.
  ///
  /// In fr, this message translates to:
  /// **'Idée ajoutée avec succès'**
  String get ideaCreated;

  /// No description provided for @genericError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue'**
  String get genericError;

  /// No description provided for @statusIdea.
  ///
  /// In fr, this message translates to:
  /// **'Idée'**
  String get statusIdea;

  /// No description provided for @statusInProgress.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get statusInProgress;

  /// No description provided for @statusDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get statusDone;

  /// No description provided for @projectStatusPlanning.
  ///
  /// In fr, this message translates to:
  /// **'Planification'**
  String get projectStatusPlanning;

  /// No description provided for @projectStatusInProgress.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get projectStatusInProgress;

  /// No description provided for @projectStatusDone.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get projectStatusDone;

  /// No description provided for @projectsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Projets'**
  String get projectsTitle;

  /// No description provided for @filterAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get filterAll;

  /// No description provided for @noProjectsYet.
  ///
  /// In fr, this message translates to:
  /// **'Aucun projet pour le moment'**
  String get noProjectsYet;

  /// No description provided for @projectNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Projet non trouvé'**
  String get projectNotFound;

  /// No description provided for @information.
  ///
  /// In fr, this message translates to:
  /// **'Informations'**
  String get information;

  /// No description provided for @startDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de début'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In fr, this message translates to:
  /// **'Fin prévue'**
  String get endDate;

  /// No description provided for @linkedIdeas.
  ///
  /// In fr, this message translates to:
  /// **'Idées liées'**
  String get linkedIdeas;

  /// No description provided for @noLinkedIdeas.
  ///
  /// In fr, this message translates to:
  /// **'Aucune idée liée à ce projet'**
  String get noLinkedIdeas;

  /// No description provided for @ideaCount.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =0{0 idée} =1{1 idée} other{{count} idées}}'**
  String ideaCount(int count);

  /// No description provided for @validationRequired.
  ///
  /// In fr, this message translates to:
  /// **'{fieldName} est requis'**
  String validationRequired(String fieldName);

  /// No description provided for @validationMinLength.
  ///
  /// In fr, this message translates to:
  /// **'{fieldName} doit contenir au moins {min} caractères'**
  String validationMinLength(String fieldName, int min);

  /// No description provided for @validationMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'{fieldName} ne doit pas dépasser {max} caractères'**
  String validationMaxLength(String fieldName, int max);

  /// No description provided for @fieldTitle.
  ///
  /// In fr, this message translates to:
  /// **'Le titre'**
  String get fieldTitle;

  /// No description provided for @fieldDescription.
  ///
  /// In fr, this message translates to:
  /// **'La description'**
  String get fieldDescription;

  /// No description provided for @fieldDefault.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ'**
  String get fieldDefault;

  /// No description provided for @timeAgoNow.
  ///
  /// In fr, this message translates to:
  /// **'à l\'instant'**
  String get timeAgoNow;

  /// No description provided for @timeAgoMinutes.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{il y a 1 minute} other{il y a {count} minutes}}'**
  String timeAgoMinutes(int count);

  /// No description provided for @timeAgoHours.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{il y a 1 heure} other{il y a {count} heures}}'**
  String timeAgoHours(int count);

  /// No description provided for @timeAgoDays.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{il y a 1 jour} other{il y a {count} jours}}'**
  String timeAgoDays(int count);

  /// No description provided for @timeAgoMonths.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{il y a 1 mois} other{il y a {count} mois}}'**
  String timeAgoMonths(int count);

  /// No description provided for @timeAgoYears.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{il y a 1 an} other{il y a {count} ans}}'**
  String timeAgoYears(int count);

  /// No description provided for @monthJan.
  ///
  /// In fr, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In fr, this message translates to:
  /// **'Fév'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In fr, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In fr, this message translates to:
  /// **'Avr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In fr, this message translates to:
  /// **'Mai'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In fr, this message translates to:
  /// **'Juin'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In fr, this message translates to:
  /// **'Juil'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In fr, this message translates to:
  /// **'Août'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In fr, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In fr, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In fr, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In fr, this message translates to:
  /// **'Déc'**
  String get monthDec;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
