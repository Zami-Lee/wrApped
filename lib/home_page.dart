import 'package:flutter/material.dart';

Color mainTextColour =  const Color(0xFF6F5E76);
Color boxColour = const Color(0xFFCEB5E7);
Color box2Colour = const Color(0xFFF9E9EC);

double customWidgetWidth = 500;

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
  // List<Widget> get userWidgets => _userWidgets;

  // bool _widgetInUserWidgets(Widget widget) {
  //   return _userWidgets.contains(widget);
  // }

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
            const SizedBox(height: 30),
            (_widgetCount == 0 || _widgetCount > 1) ?
            Text(
              "you have $_widgetCount widgets.",
              style: TextStyle(color: mainTextColour)
            ) :
            Text(
              "you have $_widgetCount widget.",
              style: TextStyle(color: mainTextColour)
            ),
            const SizedBox(height: 10),
            if (_widgetCount == 0)
              Text(
                "add more widgets to make your homepage more egg-citing ;)",
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
                                // Handle the selection state change for Widget1
                                if (isSelected) {
                                  // Widget1 is selected
                                  Widget1 widget = const Widget1();
                                  _userWidgets.add(widget);
                                } else {
                                  // Widget1 is deselected
                                  _userWidgets.removeWhere((widget) => widget is Widget1);
                                }
                              },
                              // initiallyInUserWidgets: _widgetInUserWidgets(const Widget1()),
                              child: const Widget1(),
                            ),
                            const SizedBox(height: 20),
                            SelectableWidget(
                              onSelect: (isSelected) {
                                // Handle the selection state change for Widget1
                                if (isSelected) {
                                  // Widget2 is selected
                                  Widget2 widget = const Widget2();
                                  _userWidgets.add(widget);
                                } else {
                                  // Widget2 is deselected
                                  _userWidgets.removeWhere((widget) => widget is Widget2);
                                }
                              },
                              // initiallyInUserWidgets: _widgetInUserWidgets(const Widget2()),
                              child: const Widget2(),
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
          Expanded(
              child: ListView.builder(
                itemCount: _userWidgets.length,
                itemBuilder: (BuildContext context, int index) {
                  // Build each widget based on the index

                  Widget currentWidget = _userWidgets[index];
                  return currentWidget;
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}

class SelectableWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool> onSelect;
  // final bool initiallyInUserWidgets;

  const SelectableWidget({
    required this.child,
    required this.onSelect,
    // required this.initiallyInUserWidgets
  });

  @override
  _SelectableWidgetState createState() => _SelectableWidgetState();
}

class _SelectableWidgetState extends State<SelectableWidget> {
  // TODO: isSelected is true if widget alreayd in userWidgets
  bool isSelected = false;

  // @override
  // void initState() {
  //   super.initState();
  //   isSelected = widget.initiallyInUserWidgets;
  // }

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
  int drinksCost = 34;
  int mealsCost = 103;
  int groceriesCost = 67;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: customWidgetWidth + 50,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                        child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text("your total spendings:",
                                style: TextStyle(color: mainTextColour, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: customWidgetWidth,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: box2Colour,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: spendingsTextWidget(item: "Drinks", cost: drinksCost),
                                    ),
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: spendingsTextWidget(item: "Meals", cost: mealsCost),
                                    ),
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: spendingsTextWidget(item: "Groceries", cost: groceriesCost),
                                    ),
                                  ],
                                ),
                              )
                            ]
                          )
                        )
                    );
  }
}

class spendingsTextWidget extends StatelessWidget {
  String item;
  int cost;

  spendingsTextWidget({required this.item, required this.cost});

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$item: ',
          style: TextStyle(fontWeight: FontWeight.bold, color: mainTextColour, fontSize: 16),
          textAlign: TextAlign.left,
        ),
        Text(
          '\$$cost',
          style: TextStyle(color: mainTextColour, fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

}

class Widget2 extends StatefulWidget {
  const Widget2({super.key});

  @override
  State<Widget2> createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> {
  String restaurantAImage = 'assets/images/icecream-truck.jpg';
  String restaurantBImage = 'assets/images/bakery.jpg';
  String restaurantCImage = 'assets/images/burger-restaurant.jpg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: customWidgetWidth + 50,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
                Text("your most expensive meals this month:",
                  style: TextStyle(color: mainTextColour, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),
              RestaurantRow(restaurantAImage: restaurantAImage, restaurantName: "Restaurant A", price: 60, ranking: 01),
              const SizedBox(height: 10),
              RestaurantRow(restaurantAImage: restaurantBImage, restaurantName: "Restaurant B", price: 30, ranking: 02),
              const SizedBox(height: 10),
              RestaurantRow(restaurantAImage: restaurantCImage, restaurantName: "Restaurant C", price: 20, ranking: 03),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantRow extends StatelessWidget {
  final String restaurantAImage;
  final String restaurantName;
  final int price;
  final int ranking;

  const RestaurantRow({
    required this.restaurantAImage,
    required this.restaurantName,
    required this.price,
    required this.ranking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      restaurantAImage.toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.topLeft,
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      restaurantName,
                      style: TextStyle(fontSize: 14, color: mainTextColour, fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 20),
                      Text(
                      '\$$price',
                      style: TextStyle(fontSize: 18, color: mainTextColour, fontWeight: FontWeight.w500),
                      ),
                    ]
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.topRight,
                child: Flexible(
                  child: Text('$ranking', style: TextStyle(fontSize: 18, color: mainTextColour)),
                ),
              ),
            ],
          );
  }
}
