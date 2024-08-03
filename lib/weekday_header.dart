import 'package:flutter/material.dart';

class WeekdayHeader extends StatelessWidget {
  final bool isSundayStart;

  const WeekdayHeader({this.isSundayStart = true, super.key});
/// @@ 요일 헤더를 변경하려면 이곳을 수정하세요.
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
        /// @@ 일요일 시작, 월요일 시작만 변경 가능. 추가 필요할 경우 조건 변경
        int weekday = isSundayStart ? (DateTime.sunday + index) % 7 : (DateTime.monday + index - 1) % 7 + 1;
        return Expanded(
          child: Center(
            child: Text(
              _getWeekdayInitial(weekday == 0 ? 7 : weekday),
              /// @@ 요일 헤더 스타일 변경
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}