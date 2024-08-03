import 'package:flutter/material.dart';
import 'calendar_models.dart';

class CalendarUtils {
  /// @@ 색상 순서 및 간트바 추가를 위한 색상 리스트
  static List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.grey,
    Colors.orange,
    Colors.purple,
  ];

  /// getter를 위해 static 변수로 선언
  static List<CalendarModel> _calendar = [];

  /// 주의 첫 번째 날을 반환하는 함수
  static DateTime getFirstDayOfWeek({required DateTime date, bool isSundayStart = true}) {
    int startDayOffset = isSundayStart ? DateTime.sunday : DateTime.monday;
    int difference = date.weekday - startDayOffset;

    if (difference < 0) {
      difference += 7;
    }

    return date.subtract(Duration(days: difference));
  }

  /// 한 달의 주 수를 계산하는 함수
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

  /// 달력을 생성하는 함수
  static List<CalendarModel> generateCalendar({
    required DateTime currentDate,
    bool isSundayStart = true,
    required List<DateSelectionRange> selectedRange,
  }) {
    int weeksInMonth = calculateWeeksInMonth(date: currentDate, isSundayStart: isSundayStart);
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime firstDayOfWeek = getFirstDayOfWeek(date: firstDayOfMonth, isSundayStart: isSundayStart);

    _calendar = [];

    /// 선택된 범위와 색상을 매핑하는 맵
    Map<DateSelectionRange, Color> rangeToColorMap = {
      for (int i = 0; i < selectedRange.length; i++)
        selectedRange[i]: colorList[i % colorList.length]
    };

    /// 이전 날짜의 색상을 저장하는 리스트
    List<Color> previousDayColors = List.filled(colorList.length, Colors.transparent);

    for (int i = 0; i < weeksInMonth; i++) {
      for (int j = 0; j < 7; j++) {
        DateTime day = firstDayOfWeek.add(Duration(days: i * 7 + j));

       /// CalendarModel 범위 색상을 저장하는 리스트
        /// 기본적으로 투명한 색상으로 초기화
        List<Color> rangeColorsForDay = List.filled(colorList.length, Colors.transparent);

        /// 이전 날짜의 색상을 이어가기 위해 전날의 값과 비교하여 투명을 지정하고
        /// 새로운 값이면 투명이 위치한 곳에 색상을 지정
        for (var entry in rangeToColorMap.entries) {
          if (day.isAfter(entry.key.start.subtract(const Duration(days: 1))) &&
              day.isBefore(entry.key.end.add(const Duration(days: 1)))) {
            int index = previousDayColors.indexOf(entry.value);
            if (index != -1) {
              rangeColorsForDay[index] = entry.value;
            } else {
              int emptyIndex = rangeColorsForDay.indexOf(Colors.transparent);
              rangeColorsForDay[emptyIndex] = entry.value;
            }
          }
        }

        previousDayColors = List.from(rangeColorsForDay);
        _calendar.add(CalendarModel(thisDate: day, rangeColors: rangeColorsForDay));
      }
    }

    return _calendar;
  }
/// RangeBar에서 사용할 calendar를 반환하는 getter
  static List<CalendarModel> get calendar => _calendar;
}
