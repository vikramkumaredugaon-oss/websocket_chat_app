import 'package:intl/intl.dart';

import '../constants/app_constant.dart';

class DateUtilsHelper {
  /// Convert ISO date string to DateTime
  static DateTime parse(String date) {
    return DateTime.parse(date).toLocal();
  }

  /// Chat message time → 10:45 AM
  static String formatChatTime(String date) {
    final dt = parse(date);
    return DateFormat(AppConstants.chatTimeFormat).format(dt);
  }

  /// Chat date → 27 Feb 2026
  static String formatChatDate(String date) {
    final dt = parse(date);
    return DateFormat(AppConstants.chatDateFormat).format(dt);
  }

  /// Last seen → "Last seen today at 10:45 AM"
  static String lastSeen(String date) {
    final dt = parse(date);
    final now = DateTime.now();

    if (isToday(dt)) {
      return "Today at ${DateFormat(AppConstants.chatTimeFormat).format(dt)}";
    }

    if (isYesterday(dt)) {
      return "Yesterday at ${DateFormat(AppConstants.chatTimeFormat).format(dt)}";
    }

    return DateFormat("dd MMM yyyy, hh:mm a").format(dt);
  }

  /// Chat list time (WhatsApp style)
  static String chatListTime(String date) {
    final dt = parse(date);

    if (isToday(dt)) {
      return DateFormat(AppConstants.chatTimeFormat).format(dt);
    }

    if (isYesterday(dt)) {
      return "Yesterday";
    }

    return DateFormat("dd/MM/yyyy").format(dt);
  }

  /// Helpers
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.year == date.year &&
        yesterday.month == date.month &&
        yesterday.day == date.day;
  }
}