import 'package:custom_calendar/day_tile.dart';
import 'package:custom_calendar/week_row.dart';
import 'package:custom_calendar/weekday_header.dart';
import 'package:flutter/material.dart';

import 'calendar_header.dart';
import 'calendar_utils.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? selectedDate;
  final List<DateSelectionRange>? selectedRange;

  const CustomCalendar({super.key, this.selectedDate, this.selectedRange});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime currentDate;
  late DateTime _selectedDate;
  late List<DateSelectionRange> sortedSelectedRange;

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate ?? DateTime.now();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    sortedSelectedRange = widget.selectedRange ?? [];
    sortedSelectedRange.sort((a, b) => a.start.compareTo(b.start));
  }

  @override
  Widget build(BuildContext context) {
    List<List<DateTime>> calendar = CalendarUtils.generateCalendar(
        currentDate: currentDate, isSundayStart: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 1000,
          height: 1000,
          child: Column(
            children: [
              CalendarHeader(
                currentDate: currentDate,
                onPreviousMonth: () {
                  setState(() {
                    currentDate = DateTime(currentDate.year,
                        currentDate.month - 1, currentDate.day);
                  });
                },
                onNextMonth: () {
                  setState(() {
                    currentDate = DateTime(currentDate.year,
                        currentDate.month + 1, currentDate.day);
                  });
                },
              ),
              const WeekdayHeader(isSundayStart: true),
              Expanded(
                child: Column(
                  children: List.generate(calendar.length, (index) {
                    return WeekRow(
                      selectedRanges: sortedSelectedRange,
                      week: calendar[index],
                      currentDate: currentDate,
                      selectedDate: _selectedDate,
                      onTap: (DateTime day) {
                        setState(() {
                          _selectedDate = day;
                        });
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}