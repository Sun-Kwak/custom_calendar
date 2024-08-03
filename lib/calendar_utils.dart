class CalendarUtils {
  static DateTime getFirstDayOfWeek({required DateTime date, bool isSundayStart = true}) {
    int startDayOffset = isSundayStart ? DateTime.sunday : DateTime.monday;
    int difference = date.weekday - startDayOffset;

    if (difference < 0) {
      difference += 7;
    }

    return date.subtract(Duration(days: difference));
  }

  static int calculateWeeksInMonth({required DateTime date, bool isSundayStart = true}) {
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int startDayOffset = isSundayStart ? DateTime.sunday : DateTime.monday;
    int firstWeekday = firstDayOfMonth.weekday - startDayOffset;
    int lastWeekday = lastDayOfMonth.weekday - startDayOffset;

    int daysInFirstWeek = 7 - firstWeekday;
    int daysInLastWeek = lastWeekday + 1;

    int totalDaysInMonth = lastDayOfMonth.day;
    int daysInFullWeeks = totalDaysInMonth - daysInFirstWeek - daysInLastWeek;

    int fullWeeks = (daysInFullWeeks / 7).floor();
    int weeksInMonth = 2 + fullWeeks;

    return weeksInMonth;
  }

  static List<List<DateTime>> generateCalendar({required DateTime currentDate, bool isSundayStart = true}) {
    int weeksInMonth = calculateWeeksInMonth(date: currentDate, isSundayStart: isSundayStart);
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime firstDayOfWeek = getFirstDayOfWeek(date: firstDayOfMonth, isSundayStart: isSundayStart);

    List<List<DateTime>> calendar = List.generate(
      weeksInMonth,
          (i) => List.generate(
        7,
            (j) => firstDayOfWeek.add(Duration(days: i * 7 + j)),
      ),
    );

    return calendar;
  }
}