import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../home_page.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: customWidgetPaddingLeft),
      child: SizedBox(
        width: customWidgetWidth,
        height: 440,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "monthly activity:",
              style: TextStyle(
                color: mainTextColour,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TableCalendar(
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  // CalendarFormat.week: 'Week',
                },
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2023, 12, 31),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                // onFormatChanged: (format) {
                //   setState(() {
                //     _calendarFormat = format;
                //   });
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}