import 'package:flutter/material.dart';
import 'package:thinkhub/core/l10n/app_localizations.dart';

class Formatters {
  Formatters._();

  /// Formate une date en texte relatif traduit
  static String timeAgo(BuildContext context, DateTime dateTime) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return l10n.timeAgoYears(years);
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return l10n.timeAgoMonths(months);
    } else if (difference.inDays > 0) {
      return l10n.timeAgoDays(difference.inDays);
    } else if (difference.inHours > 0) {
      return l10n.timeAgoHours(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return l10n.timeAgoMinutes(difference.inMinutes);
    } else {
      return l10n.timeAgoNow;
    }
  }

  /// Formate une date au format "dd/MM/yyyy"
  static String formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    return '$day/$month/$year';
  }

  /// Formate une date au format "dd MMM yyyy" (ex: "15 Jan 2025") - traduit
  static String formatDateShort(BuildContext context, DateTime dateTime) {
    final l10n = AppLocalizations.of(context)!;
    final months = [
      l10n.monthJan, l10n.monthFeb, l10n.monthMar, l10n.monthApr,
      l10n.monthMay, l10n.monthJun, l10n.monthJul, l10n.monthAug,
      l10n.monthSep, l10n.monthOct, l10n.monthNov, l10n.monthDec,
    ];
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year.toString();
    return '$day $month $year';
  }
}
