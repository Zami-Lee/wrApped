import 'package:flutter/material.dart';

import 'package:food_app2/custom_widgets/calendar_widget.dart';
import 'package:food_app2/custom_widgets/monthly_spend_widget.dart';
import 'package:food_app2/custom_widgets/most_exp_meal_widget.dart';
import 'package:food_app2/custom_widgets/selectable_widget.dart';

Color mainTextColour =  const Color(0xFF6F5E76);
Color boxColour = const Color(0xFFCEB5E7);
Color box2Colour = const Color(0xFFF9E9EC);

double customWidgetWidth = 500;
double customWidgetPaddingLeft = 40.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AssetImage profilePhoto = const AssetImage('assets/images/cake.jpg');
  String username = 'potato cake';
  String handle = '@potato_cake_124';
  int _widgetCount = 0;

  List<Widget> _userWidgets = [];

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 30,
              backgroundImage: profilePhoto,
              backgroundColor: boxColour,
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(color: mainTextColour, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              handle,
              style: TextStyle(color: mainTextColour, fontSize: 16),
            ),
            const SizedBox(height: 30),
            (_widgetCount == 0 || _widgetCount > 1) ?
            Text(
              "you have $_widgetCount custom widgets.",
              style: TextStyle(color: mainTextColour)
            ) :
            Text(
              "you have $_widgetCount custom widget.",
              style: TextStyle(color: mainTextColour)
            ),
            const SizedBox(height: 10),
            if (_widgetCount == 0)
              Text(
                "add custom widgets to make your homepage more egg-citing ;)",
                style: TextStyle(color: mainTextColour, fontSize: 12, fontWeight: FontWeight.w300)
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(boxColour),
              ),
              onPressed: () {
                // Show popup
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('choose your widgets', style: TextStyle(color: mainTextColour)),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            SelectableWidget(
                              onSelect: (isSelected) {
                                // Handle the selection state change for MonthlySpendWidget
                                if (isSelected) {
                                  // MonthlySpendWidget is selected
                                  MonthlySpendWidget widget = const MonthlySpendWidget();
                                  _userWidgets.add(widget);
                                } else {
                                  // MonthlySpendWidget is deselected
                                  _userWidgets.removeWhere((widget) => widget is MonthlySpendWidget);
                                }
                              },
                              child: const MonthlySpendWidget(),
                            ),
                            const SizedBox(height: 20),
                            SelectableWidget(
                              onSelect: (isSelected) {
                                // Handle the selection state change for MonthlySpendWidget
                                if (isSelected) {
                                  // MostExpMealsWidget is selected
                                  MostExpMealsWidget widget = const MostExpMealsWidget();
                                  _userWidgets.add(widget);
                                } else {
                                  // MostExpMealsWidget is deselected
                                  _userWidgets.removeWhere((widget) => widget is MostExpMealsWidget);
                                }
                              },
                              child: const MostExpMealsWidget(),
                            ),
                            // Add more SelectableWidget instances for other widgets
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(boxColour),
                          ),
                          onPressed: () {
                            setState(() {
                              Set<Widget> uniqueSet = Set<Widget>.from(_userWidgets);
                              _userWidgets = uniqueSet.toList();
                              _widgetCount = _userWidgets.length;
                            });
                            // Close the popup
                            Navigator.of(context).pop();
                          },
                          child: const Text('select widgets', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('select widgets'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const CalendarWidget(),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _userWidgets.length,
              itemBuilder: (BuildContext context, int index) {
                // Build each widget based on the index
                Widget currentWidget = _userWidgets[index];
                return currentWidget;
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}