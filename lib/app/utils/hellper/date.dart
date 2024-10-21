import 'package:intl/intl.dart';

class Dates {
  static String formated(String dateTime) {
    final DateTime getDate = DateTime.parse(dateTime);
    final DateTime nowDate = DateTime.now();
    final Duration differenceDate = nowDate.difference(getDate);

    if (differenceDate.inSeconds < 60) {
      return '${differenceDate.inSeconds} seconds ago';
    } else if (differenceDate.inMinutes < 60) {
      return '${differenceDate.inMinutes} minutes ago';
    } else if (differenceDate.inHours < 24) {
      return '${differenceDate.inHours} hours ago';
    } else {
      final days = differenceDate.inDays;
      return days == 1 ? '1 day ago' : '$days days ago';
    }
  }


  static String yyyyMMdd(DateTime date) {
    return DateFormat('yyyyMMdd_HHmmss').format(date);
  }
}
