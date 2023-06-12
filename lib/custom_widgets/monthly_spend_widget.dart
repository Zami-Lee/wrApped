import 'package:flutter/material.dart';
import '../home_page.dart';


class MonthlySpendWidget extends StatefulWidget {
  const MonthlySpendWidget({super.key});

  @override
  State<MonthlySpendWidget> createState() => _MonthlySpendWidgetState();
}

class _MonthlySpendWidgetState extends State<MonthlySpendWidget> {
  int drinksCost = 34;
  int mealsCost = 103;
  int groceriesCost = 67;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: customWidgetWidth + 50,
            height: 250,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: customWidgetPaddingLeft),
                child:
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text("monthly spendings:",
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
                              child: SpendingsTextWidget(item: "Drinks", cost: drinksCost),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: SpendingsTextWidget(item: "Meals", cost: mealsCost),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: SpendingsTextWidget(item: "Groceries", cost: groceriesCost),
                            ),
                          ],
                        ),
                      )
                    ]
                  )
                )
              )
            );
  }

}

class SpendingsTextWidget extends StatelessWidget {
  String item;
  int cost;

  SpendingsTextWidget({required this.item, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$item: ',
          style: TextStyle(fontWeight: FontWeight.bold, color: mainTextColour, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          '\$$cost',
          style: TextStyle(color: mainTextColour, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    )
    );
  }
}