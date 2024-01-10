import 'package:intl/intl.dart';

extension T on DateTime {
  String get yMMMEd => DateFormat.yMMMEd().format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == (now.day - 1);
  }
}
