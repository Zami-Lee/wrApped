import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({super.key});
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AssetImage profilePhoto = const AssetImage('assets/images/cake.jpg');
  String username = 'cake cake';
  String handle = '@cake_cake_1928';
  int widgetCount = 0;

  List<Widget> userWidgets = [];

  Color mainTextColour = const Color(0xFF485868);
  Color boxColour = const Color.fromRGBO(219, 250, 165, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            const SizedBox(height: 20),
            Text(
              "you have $widgetCount widget(s) currently.",
              style: TextStyle(color: mainTextColour)
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
                      title: const Text('choose widget'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            SelectableWidget(
                              child: const Widget1(),
                              onSelect: (isSelected) {
                                // Handle the selection state change for Widget1
                                if (isSelected) {
                                  // Widget1 is selected
                                  Widget1 widget = const Widget1();
                                  userWidgets.add(widget);
                                  widgetCount += 1;
                                } else {
                                  // Widget1 is deselected
                                  userWidgets.removeWhere((widget) => widget is Widget1);
                                  widgetCount -= 1;
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            SelectableWidget(
                              child: const Widget2(),
                              onSelect: (isSelected) {
                                // Handle the selection state change for Widget1
                                if (isSelected) {
                                  // Widget2 is selected
                                  Widget2 widget = const Widget2();
                                  userWidgets.add(widget);
                                  widgetCount += 1;
                                } else {
                                  // Widget2 is deselected
                                  userWidgets.removeWhere((widget) => widget is Widget2);
                                  widgetCount -= 1;
                                }
                              },
                            ),
                            // Add more SelectableWidget instances for other widgets
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                            });
                            // Close the popup
                            Navigator.of(context).pop();
                          },
                          child: const Text('add widgets'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Add Widget'),
            ),
          Expanded(
              child: ListView.builder(
                itemCount: userWidgets.length,
                itemBuilder: (BuildContext context, int index) {
                  // Build each widget based on the index

                  Widget currentWidget = userWidgets[index];
                  return currentWidget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool> onSelect;

  const SelectableWidget({
    required this.child,
    required this.onSelect,
  });

  @override
  _SelectableWidgetState createState() => _SelectableWidgetState();
}

class _SelectableWidgetState extends State<SelectableWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelect(isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2.0,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class Widget1 extends StatefulWidget {
  const Widget1({super.key});

  @override
  State<Widget1> createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
                    width: 200,
                    height: 200,
                    child: Text(
                      "Widget 1",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
  }
}

class Widget2 extends StatefulWidget {
  const Widget2({super.key});

  @override
  State<Widget2> createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
                    width: 200,
                    height: 200,
                    child: Text(
                      "Widget 2",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
  }
}
