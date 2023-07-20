import 'package:flutter/material.dart';
import 'package:food_app2/main.dart';
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

  Map<DateTime, Map<String, double>> dailySpendings = {};

  void addExpenseDialogue(BuildContext context, DateTime date) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(date);

    TextEditingController expenseController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    String priceErrorText = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(formattedDate, style: TextStyle(color: mainTextColour, fontWeight: FontWeight.bold)),
              content: Column(
                children: [
                  TextField(
                    controller: expenseController,
                    decoration: const InputDecoration(
                      labelText: 'expense',
                    ),
                  ),
                  TextField(
                    controller: priceController,
                    onChanged: (value) {
                      double? parsedValue = double.tryParse(value);
                      if (parsedValue != null) {
                        setState(() {
                          priceErrorText = '';
                        });
                      } else {
                        setState(() {
                          priceErrorText = 'error - please enter a numerical value';
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'price',
                      errorText: priceErrorText.isNotEmpty ? priceErrorText : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(boxColour),
                    ),
                    onPressed: () {
                      String expense = expenseController.text;
                      double price = double.tryParse(priceController.text) ?? 0;
                      if (price != 0 && priceErrorText.isEmpty) {
                        setState(() {
                          (dailySpendings[date] ??= {})[expense] = price;
                        });
                        Navigator.of(context).pop();
                        // small workaround to immediately close both to refresh
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('add expense'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showDatePopup(BuildContext context, DateTime date) async {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(date);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.white,
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
                    addExpenseDialogue(context, date);
                  },
                  child: const Text('add an expense'),
                ),
              ),
              const SizedBox(height: 20),
              dailySpendings[date]?.isEmpty ?? true ? Text('you have no recorded spendings.', style: TextStyle(color: mainTextColour, fontWeight: FontWeight.bold)) : Text('spendings:', style: TextStyle(color: mainTextColour, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (dailySpendings[date]?.entries ?? [])
                  .map((entry) => Text(
                        '${entry.key}: \$${entry.value.toStringAsFixed(2)} \n',
                        style: TextStyle(color: mainTextColour),
                      ))
                  .toList()
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(boxColour),
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
                  color: box2Colour,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: boxColourLight,
                    ),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: boxColour,
                    ),
                  ),
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.now(),
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
