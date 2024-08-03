import 'package:flutter/material.dart';

import 'day_tile.dart';

class WeekRow extends StatelessWidget {
  final List<DateTime> week;
  final DateTime currentDate;
  final DateTime selectedDate;
  final Function(DateTime) onTap;

  const WeekRow({
    required this.week,
    required this.currentDate,
    required this.selectedDate,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (dayIndex) {
          DateTime day = week[dayIndex];
          bool isCurrentMonth = day.month == currentDate.month;

          return Expanded(
            child: DayTile(
              onTap: onTap, // Pass the onTap function directly
              day: day,
              isCurrentMonth: isCurrentMonth,
              selectedDate: selectedDate,
            ),
          );
        }),
      ),
    );
  }
}