import 'package:flutter/material.dart';
import 'date_range_bar.dart';

class DayTile extends StatelessWidget {
  final DateTime day;
  final bool isCurrentMonth;
  final DateTime selectedDate;
  final Function(DateTime) onTap;

  const DayTile({
    required this.day,
    required this.isCurrentMonth,
    required this.selectedDate,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = day.year == selectedDate.year &&
        day.month == selectedDate.month &&
        day.day == selectedDate.day;

    return InkWell(
      onTap: () => onTap(day),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected

              /// @@ 선택된 날짜 색상 변경
              ? Colors.red
              : isCurrentMonth
                  /// @@ 현재 월의 날짜 색상 변경
                  ? Colors.blue
                  /// @@ 다른 월의 날짜 색상 변경
                  : Colors.grey.withOpacity(0.3),
        ),
        child: Column(
          children: [
            /// @@ 날짜 표시 스타일 변경
            Text(
              '${day.day}',
              style: TextStyle(
                color:
                    /// @@ 현재월과 다른월의 텍스트 색상, 선택된 날짜 색상 변경을 위해 추가 조건 필요
                    isSelected || isCurrentMonth ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// @@ DateRangeBar
            DateRangeBar(
              day: day,
            ),
          ],
        ),
      ),
    );
  }
}
