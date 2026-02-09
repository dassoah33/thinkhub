// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'ThinkHub';

  @override
  String get navDashboard => 'Inicio';

  @override
  String get navIdeas => 'Ideas';

  @override
  String get navProjects => 'Proyectos';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get dashboardSubtitle => 'Resumen de tus ideas y proyectos';

  @override
  String get statsTotalIdeas => 'Total ideas';

  @override
  String get statsProjects => 'Proyectos';

  @override
  String get statsInProgress => 'En curso';

  @override
  String get recentIdeas => 'Ideas recientes';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get newIdea => 'Nueva idea';

  @override
  String get viewIdeas => 'Ver ideas';

  @override
  String get viewProjects => 'Ver proyectos';

  @override
  String get noIdeasYet => 'Ninguna idea por el momento';

  @override
  String get addFirstIdea => '¡Añade tu primera idea!';

  @override
  String get tapPlusToStart => 'Pulsa + para empezar';

  @override
  String get loadingError => 'Error de carga';

  @override
  String get retry => 'Reintentar';

  @override
  String get ideasTitle => 'Ideas';

  @override
  String get deleteIdeaTitle => '¿Eliminar esta idea?';

  @override
  String get deleteIdeaContent => 'Esta acción es irreversible.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get ideaDeleted => 'Idea eliminada';

  @override
  String get editIdea => 'Modificar idea';

  @override
  String get newIdeaTitle => 'Nueva idea';

  @override
  String get titleLabel => 'Título';

  @override
  String get titleHint => 'Dale un título a tu idea';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get descriptionHint => 'Describe tu idea en detalle...';

  @override
  String get statusLabel => 'Estado';

  @override
  String get save => 'Guardar';

  @override
  String get ideaUpdated => 'Idea modificada con éxito';

  @override
  String get ideaCreated => 'Idea añadida con éxito';

  @override
  String get genericError => 'Ha ocurrido un error';

  @override
  String get statusIdea => 'Idea';

  @override
  String get statusInProgress => 'En curso';

  @override
  String get statusDone => 'Terminado';

  @override
  String get projectStatusPlanning => 'Planificación';

  @override
  String get projectStatusInProgress => 'En curso';

  @override
  String get projectStatusDone => 'Terminado';

  @override
  String get projectsTitle => 'Proyectos';

  @override
  String get filterAll => 'Todos';

  @override
  String get noProjectsYet => 'Ningún proyecto por el momento';

  @override
  String get projectNotFound => 'Proyecto no encontrado';

  @override
  String get information => 'Información';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get endDate => 'Fin previsto';

  @override
  String get linkedIdeas => 'Ideas vinculadas';

  @override
  String get noLinkedIdeas => 'Ninguna idea vinculada a este proyecto';

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
    return '$fieldName es obligatorio';
  }

  @override
  String validationMinLength(String fieldName, int min) {
    return '$fieldName debe contener al menos $min caracteres';
  }

  @override
  String validationMaxLength(String fieldName, int max) {
    return '$fieldName no debe superar $max caracteres';
  }

  @override
  String get fieldTitle => 'El título';

  @override
  String get fieldDescription => 'La descripción';

  @override
  String get fieldDefault => 'Este campo';

  @override
  String get timeAgoNow => 'ahora mismo';

  @override
  String timeAgoMinutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count minutos',
      one: 'hace 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String timeAgoHours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count horas',
      one: 'hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String timeAgoDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count días',
      one: 'hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String timeAgoMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count meses',
      one: 'hace 1 mes',
    );
    return '$_temp0';
  }

  @override
  String timeAgoYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count años',
      one: 'hace 1 año',
    );
    return '$_temp0';
  }

  @override
  String get monthJan => 'Ene';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Abr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Ago';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dic';
}
