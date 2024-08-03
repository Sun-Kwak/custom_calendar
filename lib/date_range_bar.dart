import 'package:flutter/material.dart';

import 'calendar_models.dart';
import 'calendar_utils.dart';

class DateRangeBar extends StatelessWidget {
  final DateTime day;

  const DateRangeBar({
    required this.day,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime beforeDay = day.subtract(const Duration(days: 1));
    final DateTime afterDay = day.add(const Duration(days: 1));
    List<Color>? rangeList = CalendarModel.getRangeColorsForDate(
      calendar: CalendarUtils.calendar,
      date: day,
    );

    /// 이전 날짜를 달력에서 전날을 부여해서 가져옵니다.
    List<Color>? beforeRangeList = CalendarModel.getRangeColorsForDate(
      calendar: CalendarUtils.calendar,
      date: beforeDay,
    );

    /// 다음 날짜를 달력에서 다음날을 부여해서 가져옵니다.
    List<Color>? afterRangeList = CalendarModel.getRangeColorsForDate(
      calendar: CalendarUtils.calendar,
      date: afterDay,
    );

    List<Color> rangeColors = rangeList ?? [];

    return Expanded(child: LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth / 3;
        return Column(
          children: List.generate(rangeList!.length, (index) {
            Color color = rangeColors[index % rangeColors.length];

            /// 이전 날짜와 다음 날짜가 같은 색상이 아닌 경우에만 margin을 부여합니다.
            bool isStart =
                (beforeRangeList == null || !beforeRangeList.contains(color));
            bool isEnd =
                (afterRangeList == null || !afterRangeList.contains(color));
            return Container(
              margin: EdgeInsets.only(
                /// @@ Bar의 vertical 간격을 조정합니다.
                  top: constraints.maxHeight * 0.03,
                  /// @@ 시작, 끝에 margin을 부여합니다. 필요 시 변경
                  left: isStart ? 15 : 0.0,
                  right: isEnd ? 15 : 0.0),
              /// @@ Bar의 높이를 조정합니다. 필요 시 변경
              height: constraints.maxHeight * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  /// @@ 시작, 끝에 radius를 부여합니다. 필요 시 변경
                  left: isStart ? const Radius.circular(20) : Radius.zero,
                  right: isEnd ? const Radius.circular(20) : Radius.zero,
                ),
                color: rangeColors[index % rangeColors.length],
              ),
            );
          }),
        );
      },
    ));
  }
}
