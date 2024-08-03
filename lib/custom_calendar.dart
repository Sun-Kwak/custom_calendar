import 'package:custom_calendar/week_row.dart';
import 'package:custom_calendar/weekday_header.dart';
import 'package:flutter/material.dart';
import 'calendar_header.dart';
import 'calendar_models.dart';
import 'calendar_utils.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? selectedDate;
  final List<DateSelectionRange>? selectedRange;

  const CustomCalendar({super.key, this.selectedDate, this.selectedRange});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  /// current date는 현재 달력의 표시를 위해 사용
  late DateTime currentDate;
  /// selected date는 사용자가 선택한 날짜를 저장
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
    List<CalendarModel> calendarModels = CalendarUtils.generateCalendar(
      currentDate: currentDate,
      isSundayStart: true,
      selectedRange: sortedSelectedRange,
    );

    List<List<CalendarModel>> calendar = [];
    for (var i = 0; i < calendarModels.length; i += 7) {
      calendar.add(calendarModels.sublist(i, i + 7));
    }

    return Scaffold(
      /// @@ 불필요
      appBar: AppBar(
        title: const Text('Simple Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CalendarHeader(
              currentDate: currentDate,
              /// @@ 이전 달로 이동하는 버튼을 누르면 현재 달력의 날짜를 이전 달로 변경합니다.
              onPreviousMonth: () {
                setState(() {
                  currentDate = DateTime(currentDate.year,
                      currentDate.month - 1, currentDate.day);
                });
              },
              /// @@ 다음 달로 이동하는 버튼을 누르면 현재 달력의 날짜를 다음 달로 변경합니다.
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
                    week: calendar[index].map((model) => model.thisDate).toList(),
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
    );
  }
}