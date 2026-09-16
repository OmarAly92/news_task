import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:news_task/core/helpers/localization/locale_keys.g.dart';

sealed class FormatHelper {
  /// Formats a double value as currency with comma separators
  /// Example: 1000.50 → "1,000.50"
  static String formatCurrency(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(amount);
  }

  /// Formats an integer value with comma separators
  /// Example: 1000 → "1,000"
  static String formatInteger(int amount) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount);
  }

  /// Parses a formatted currency string back to double
  /// Example: "1,000.50" → 1000.50
  /// Returns 0.0 if parsing fails
  static double parseCurrency(String text) {
    try {
      final cleanText = text.replaceAll(',', '').trim();
      if (cleanText.isEmpty) {
        return 0.0;
      }
      return double.parse(cleanText);
    } catch (e) {
      return 0.0;
    }
  }

  /// Parses a formatted integer string back to int
  /// Example: "1,000" → 1000
  /// Returns 0 if parsing fails
  static int parseInteger(String text) {
    try {
      final cleanText = text.replaceAll(',', '').trim();
      if (cleanText.isEmpty) {
        return 0;
      }
      return int.parse(cleanText);
    } catch (e) {
      return 0;
    }
  }

  static String timeAgo(DateTime? date, {DateTime? now}) {
    if (date == null) return '';
    final diff = (now ?? DateTime.now()).difference(date.toLocal());
    if (diff.inMinutes < 1) return LocaleKeys.justNow.tr();
    if (diff.inHours < 1) {
      return LocaleKeys.minutesAgoShort.tr(args: ['${diff.inMinutes}']);
    }
    if (diff.inDays < 1) {
      return LocaleKeys.hoursAgoShort.tr(args: ['${diff.inHours}']);
    }
    if (diff.inDays < 7) {
      return LocaleKeys.daysAgoShort.tr(args: ['${diff.inDays}']);
    }
    return DateFormat.MMMd().format(date.toLocal());
  }
}
