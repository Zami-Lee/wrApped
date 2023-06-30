import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_app2/category.dart';
import 'package:food_app2/home_page.dart';

class MonthlySpendCategoriesWidget extends StatefulWidget {
  const MonthlySpendCategoriesWidget({required Key key}) : super(key: key);

  @override
  State<MonthlySpendCategoriesWidget> createState() =>
      _MonthlySpendCategoriesWidgetState();
}

class _MonthlySpendCategoriesWidgetState extends State<MonthlySpendCategoriesWidget> {
  final List<Category> userCategories = [
    Category(categoryName: "food", totalAmountSpent: 50),
    Category(categoryName: "drinks", totalAmountSpent: 25),
    Category(categoryName: "brunch", totalAmountSpent: 37),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: customWidgetWidth + 50,
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
                      barChart(context),
                    ]
                  )
                )
            )
    );
  }

  Widget barChart(BuildContext context) {
    return SizedBox(
      width: customWidgetWidth + 50,
      height: 200,
        child:
          BarChart(
            BarChartData(
              backgroundColor: box2Colour,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              barGroups: userCategories.map((category) {
                return BarChartGroupData(
                  x: userCategories.indexOf(category),
                  barRods: [
                    BarChartRodData(
                      toY: category.totalAmountSpent.toDouble(),
                      color: boxColourLight,
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      return Text(userCategories[value.toInt()].categoryName, style: TextStyle(color: mainTextColour),);
    },
  );
}
