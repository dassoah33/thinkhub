// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ThinkHub';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navIdeas => 'Ideas';

  @override
  String get navProjects => 'Projects';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get dashboardSubtitle => 'Overview of your ideas and projects';

  @override
  String get statsTotalIdeas => 'Total ideas';

  @override
  String get statsProjects => 'Projects';

  @override
  String get statsInProgress => 'In progress';

  @override
  String get recentIdeas => 'Recent ideas';

  @override
  String get viewAll => 'View all';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get newIdea => 'New idea';

  @override
  String get viewIdeas => 'View ideas';

  @override
  String get viewProjects => 'View projects';

  @override
  String get noIdeasYet => 'No ideas yet';

  @override
  String get addFirstIdea => 'Add your first idea!';

  @override
  String get tapPlusToStart => 'Tap + to get started';

  @override
  String get loadingError => 'Loading error';

  @override
  String get retry => 'Retry';

  @override
  String get ideasTitle => 'Ideas';

  @override
  String get deleteIdeaTitle => 'Delete this idea?';

  @override
  String get deleteIdeaContent => 'This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get ideaDeleted => 'Idea deleted';

  @override
  String get editIdea => 'Edit idea';

  @override
  String get newIdeaTitle => 'New idea';

  @override
  String get titleLabel => 'Title';

  @override
  String get titleHint => 'Give your idea a title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Describe your idea in detail...';

  @override
  String get statusLabel => 'Status';

  @override
  String get save => 'Save';

  @override
  String get ideaUpdated => 'Idea updated successfully';

  @override
  String get ideaCreated => 'Idea added successfully';

  @override
  String get genericError => 'An error occurred';

  @override
  String get statusIdea => 'Idea';

  @override
  String get statusInProgress => 'In progress';

  @override
  String get statusDone => 'Done';

  @override
  String get projectStatusPlanning => 'Planning';

  @override
  String get projectStatusInProgress => 'In progress';

  @override
  String get projectStatusDone => 'Done';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get filterAll => 'All';

  @override
  String get noProjectsYet => 'No projects yet';

  @override
  String get projectNotFound => 'Project not found';

  @override
  String get information => 'Information';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'Expected end';

  @override
  String get linkedIdeas => 'Linked ideas';

  @override
  String get noLinkedIdeas => 'No ideas linked to this project';

  @override
  String ideaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ideas',
      one: '1 idea',
      zero: '0 ideas',
    );
    return '$_temp0';
  }

  @override
  String validationRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName must contain at least $min characters';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName must not exceed $max characters';
  }

  @override
  String get fieldTitle => 'Title';

  @override
  String get fieldDescription => 'Description';

  @override
  String get fieldDefault => 'This field';

  @override
  String get timeAgoNow => 'just now';

  @override
  String timeAgoMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String timeAgoHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String timeAgoDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String timeAgoMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months ago',
      one: '1 month ago',
    );
    return '$_temp0';
  }

  @override
  String timeAgoYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years ago',
      one: '1 year ago',
    );
    return '$_temp0';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';
}
