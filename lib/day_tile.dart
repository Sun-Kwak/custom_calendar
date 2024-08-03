import 'package:flutter/material.dart';

class DayTile extends StatelessWidget {
  final DateTime day;
  final bool isCurrentMonth;
  final DateTime selectedDate;
  final Function(DateTime) onTap;
  final List<DateSelectionRange>? selectedRanges;

  const DayTile({
    required this.day,
    required this.isCurrentMonth,
    required this.selectedDate,
    required this.onTap,
    this.selectedRanges,
    super.key,
  });

  static const List<Color> rangeColors = [
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.grey,
  ];

  List<MapEntry<int, DateSelectionRange>> getSelectedRangeEntries(DateTime date) {
    List<MapEntry<int, DateSelectionRange>> entries = [];
    if (selectedRanges != null) {
      for (int i = 0; i < selectedRanges!.length; i++) {
        if (selectedRanges![i].contains(date)) {
          entries.add(MapEntry(i, selectedRanges![i]));
        }
      }
    }
    entries.sort((a, b) => a.value.start.compareTo(b.value.start));
    return entries;
  }

  List<MapEntry<int, DateSelectionRange>> adjustRangeEntries(
      List<MapEntry<int, DateSelectionRange>> beforeRangeEntries,
      List<MapEntry<int, DateSelectionRange>> rangeEntries,
      ) {
    List<int> beforeKeys = beforeRangeEntries.map((e) => e.key).toList();
    List<MapEntry<int, DateSelectionRange>> adjustedEntries = [];
    int newIndex = 0;

    for (var entry in rangeEntries) {
      if (beforeKeys.contains(entry.key)) {
        adjustedEntries.add(entry);
      } else {
        while (beforeKeys.contains(newIndex) || adjustedEntries.any((e) => e.key == newIndex)) {
          newIndex++;
        }
        adjustedEntries.add(MapEntry(newIndex, entry.value));
      }
    }
    return adjustedEntries;
  }



  @override
  Widget build(BuildContext context) {
    bool isSelected = day.year == selectedDate.year &&
        day.month == selectedDate.month &&
        day.day == selectedDate.day;
    final previousDay = day.subtract(const Duration(days: 1));
    List<MapEntry<int, DateSelectionRange>> rangeEntries = getSelectedRangeEntries(day);
    List<MapEntry<int, DateSelectionRange>> beforeRangeEntries = getSelectedRangeEntries(previousDay);
    List<MapEntry<int, DateSelectionRange>> adjustedRangeEntries = adjustRangeEntries(beforeRangeEntries, rangeEntries);
    print('Day: $day, Range Entries: $rangeEntries, Adjusted Entries: $adjustedRangeEntries');
    return InkWell(
      onTap: () => onTap(day),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.red
              : isCurrentMonth
              ? Colors.blue
              : Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Text(
              '${day.day}',
              style: TextStyle(
                color: isSelected || isCurrentMonth ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            DateRangeBar(
              rangeEntries: adjustedRangeEntries,
              day: day,
              rangeColors: rangeColors,
            ),
          ],
        ),
      ),
    );
  }
}

class DateSelectionRange {
  final DateTime start;
  final DateTime end;
  final Key key;

  DateSelectionRange({required this.start, required this.end})
      : key = UniqueKey();

  bool contains(DateTime date) {
    return date.isAfter(start.subtract(const Duration(days: 1))) &&
        date.isBefore(end.add(const Duration(days: 1)));
  }
}

class DateRangeBar extends StatelessWidget {
  final List<MapEntry<int, DateSelectionRange>> rangeEntries;
  final DateTime day;
  final List<Color> rangeColors;

  const DateRangeBar({
    required this.rangeEntries,
    required this.day,
    required this.rangeColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rangeColors.length, (index) {
        DateSelectionRange? range;
        bool isStart = false;
        bool isEnd = false;

        for (var entry in rangeEntries) {
          if (entry.key == index) {
            range = entry.value;
            isStart = range.start == day;
            isEnd = range.end == day;
            break;
          }
        }

        return Container(
          margin: EdgeInsets.only(top: 4.0, left: isStart ? 15 : 0.0, right: isEnd ? 15 : 0.0),
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: isStart ? const Radius.circular(20) : Radius.zero,
              right: isEnd ? const Radius.circular(20) : Radius.zero,
            ),
            color: range != null ? rangeColors[index] : Colors.transparent,
          ),
        );
      }),
    );
  }
}
