import 'package:flutter/material.dart';
import 'package:food_app2/home_page.dart';

class MostExpMealsWidget extends StatefulWidget {
  const MostExpMealsWidget({super.key});

  @override
  State<MostExpMealsWidget> createState() => _MostExpMealsWidgetState();
}

class _MostExpMealsWidgetState extends State<MostExpMealsWidget> {
  String restaurantAImage = 'assets/images/icecream-truck.jpg';
  String restaurantBImage = 'assets/images/bakery.jpg';
  String restaurantCImage = 'assets/images/burger-restaurant.jpg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: customWidgetWidth + 50,
      height: 400,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: customWidgetPaddingLeft),
        child: Flexible(
          fit: FlexFit.loose, // Allow the widget to shrink if needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "most expensive meals this month:",
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              restaurantAImage.toString(),
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantName,
                  style: TextStyle(fontSize: 14, color: mainTextColour, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 20),
                Text(
                  '\$$price',
                  style: TextStyle(fontSize: 18, color: mainTextColour, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 30),
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.topRight,
          child: Text('$ranking', style: TextStyle(fontSize: 18, color: mainTextColour)),
        ),
      ],
    );
  }

}
