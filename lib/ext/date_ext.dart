import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String toDDmmYYYYHHmm() {
    return DateFormat("dd MMM yyyy hh:mm aa").format(this);
  }

  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return year == today.year && month == today.month && day == today.day;
  }

  bool isThisMonth() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month);
    return year == today.year && month == today.month;
  }
}
