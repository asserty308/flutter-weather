class DateUtils {
  static String getWeekdayString(DateTime date) {
    switch (date.weekday) {
      case 1: return "Montag";
      case 2: return "Dienstag";
      case 3: return "Mittwoch";
      case 4: return "Donnerstag";
      case 5: return "Freitag";
      case 6: return "Samstag";
      case 7: return "Sonntag";
    }

    return "";
  }

  static String getDateStringFromUnixSecs(int unix) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return DateUtils.getDateStringFromDate(date);
  }

  static String getDateStringFromDate(DateTime date) {
    var weekday = DateUtils.getWeekdayString(date);
    var day = date.day < 10 ? "0" + date.day.toString() : date.day.toString();
    var month = date.month < 10 ? "0" + date.month.toString() : date.month.toString();
    var year = date.year;

    return "${weekday}, ${day}.${month}.${year}";
  }
}