import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

  final Map<String, double> _dailySpendings = {
    "Starbucks" : 17.50,
    "Hungry Jack's" : 23,
    "Papa's Pizzeria" : 28,
  };

  Future<void> _showDatePopup(BuildContext context, DateTime date) async {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(date);

    String expense = "expense";
    double price = 0;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.white, // Set the desired background color
        ),
        child: AlertDialog(
          title: Text(formattedDate, style: TextStyle(color: mainTextColour, fontWeight: FontWeight.bold)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(boxColour),
                  ),
                  onPressed: () {
                    // Perform the action for the "Add Expense" button
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('add expense'),
                          content: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    expense = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'expense',
                                ),
                              ),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    price = double.tryParse(value) ?? 0;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'price',
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(boxColour),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _dailySpendings[expense] = price;
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text('add expense'),
                              ),
                            ],
                          )
                        );
                      }
                    );
                  },
                  child: const Text('add an expense'),
                ),
              ),
              const SizedBox(height: 20),
              _dailySpendings.isNotEmpty ? Text('spendings:', style: TextStyle(color: mainTextColour, fontWeight: FontWeight.bold),) : Text('you have no recorded spendings.', style: TextStyle(color: mainTextColour, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _dailySpendings.entries
                  .map((entry) => Text(
                        '${entry.key}: \$${entry.value.toStringAsFixed(2)} \n',
                        style: TextStyle(color: mainTextColour),
                      ))
                  .toList(),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(boxColour), // Set the desired background color
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('close'),
            ),
          ],
        )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: customWidgetPaddingLeft),
      child: SizedBox(
        width: customWidgetWidth,
        height: 455,
        child: Column(
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
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: box2Colour, // Set the desired background color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: boxColourLight, // Change the color here for selected date
                    ),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: boxColour, // Change the color here for today's date
                    ),
                  ),
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
                      _showDatePopup(context, selectedDay);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
