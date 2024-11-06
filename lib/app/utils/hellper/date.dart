import 'package:intl/intl.dart';

class Dates {
  static String formated(String dateTime) {
    final DateTime getDate = DateTime.parse(dateTime);
    final DateTime nowDate = DateTime.now();
    final Duration differenceDate = nowDate.difference(getDate);
    final int days = differenceDate.inDays;
    const int month = 1;
    const int year = 1;

    if (differenceDate.inSeconds < 60) {
      return '${differenceDate.inSeconds} seconds ago';
    } else if (differenceDate.inMinutes < 60) {
      return '${differenceDate.inMinutes} minutes ago';
    } else if (differenceDate.inHours < 24) {
      return '${differenceDate.inHours} hours ago';
    } else {
      if (days == 1) {
        return '1 day ago';
      } else if (days > 1 && days < 30) {
        return '$days days ago';
      } else if (days == 30) {
        return '$month month ago';
      } else if (days > 30 && days < 365) {
        return '${month + 1} monts ago';
      } else if (days == 365) {
        return '$year year ago';
      } else {
        return '${year + 1} years ago';
      }
    }
  }

  static String yyyyMMdd(DateTime date) {
    return DateFormat('yyyyMMdd_HHmmss').format(date);
  }
}
