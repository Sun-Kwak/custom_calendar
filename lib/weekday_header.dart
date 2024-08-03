import 'package:flutter/material.dart';

class WeekdayHeader extends StatelessWidget {
  final bool isSundayStart;

  const WeekdayHeader({this.isSundayStart = true, super.key});

  String _getWeekdayInitial(int weekday) {
    switch (weekday) {
      case DateTime.sunday:
        return '일';
      case DateTime.monday:
        return '월';
      case DateTime.tuesday:
        return '화';
      case DateTime.wednesday:
        return '수';
      case DateTime.thursday:
        return '목';
      case DateTime.friday:
        return '금';
      case DateTime.saturday:
        return '토';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        int weekday = isSundayStart ? (DateTime.sunday + index) % 7 : (DateTime.monday + index - 1) % 7 + 1;
        return Expanded(
          child: Center(
            child: Text(
              _getWeekdayInitial(weekday == 0 ? 7 : weekday),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}