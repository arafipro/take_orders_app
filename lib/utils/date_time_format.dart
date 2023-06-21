import "package:intl/intl.dart";

String checkToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("yyyy-MM-dd");
  String today = formatter.format(now);
  return today;
}
