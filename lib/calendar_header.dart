import 'package:flutter/material.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime currentDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const CalendarHeader({
    required this.currentDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// @@ 달력 이동 버튼 등 커스텀 여기서 변경하세요.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onPreviousMonth,
          ),
          /// @@ 년도 또는 월 선택 이동을 추가하려면 onTap CallBack 추가해서 picker를 띄우세요.
          Text(
            /// @@ 달력 헤더에 현재 년도와 월을 표시합니다. 포멧팅이 필요하면 변경 하세요.
            '${currentDate.year}년 ${currentDate.month}월',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onNextMonth,
          ),
        ],
      ),
    );
  }
}