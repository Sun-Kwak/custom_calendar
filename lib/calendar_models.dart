import 'package:flutter/material.dart';

/// 달력의 날짜를 표현하는 모델
/// 색상을 기준으로 UI가 이어지도록 설계하였기 때문에 색상 List를 가지고 있음
class CalendarModel {
  final DateTime thisDate;
  final List<Color> rangeColors;

  CalendarModel({required this.thisDate, required this.rangeColors});

  static List<Color>? getRangeColorsForDate({
    required List<CalendarModel> calendar,
    required DateTime date,
  }) {
    for (var model in calendar) {
      if (model.thisDate.year == date.year &&
          model.thisDate.month == date.month &&
          model.thisDate.day == date.day) {
        return model.rangeColors;
      }
    }
    return null;
  }
}

/// 시작일과 종료일을 전달 받는 기본
class DateSelectionRange {
  final DateTime start;
  final DateTime end;

  DateSelectionRange({required this.start, required this.end});

  bool contains(DateTime date) {
    return date.isAfter(start.subtract(const Duration(days: 1))) &&
        date.isBefore(end.add(const Duration(days: 1)));
  }
}
