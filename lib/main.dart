import 'package:custom_calendar/custom_calendar.dart';
import 'package:flutter/material.dart';

import 'day_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomCalendar(
        selectedRange: [
          DateSelectionRange(
            start: DateTime(2024, 8, 1),
            end: DateTime(2024, 8, 5),
          ),
          DateSelectionRange(
            start: DateTime(2024, 8, 07),
            end: DateTime(2024, 8, 10),
          ),
          DateSelectionRange(
            start: DateTime(2024, 8, 5
            ),
            end: DateTime(2024, 8, 10),
          ),

        ],
      ),
    );
  }
}
