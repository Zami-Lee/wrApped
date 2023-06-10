import 'package:flutter/material.dart';

import 'explore_page.dart';
import 'home_page.dart';
import 'photo_page.dart';

void main() => runApp(FoodSocialMediaApp());

class FoodSocialMediaApp extends StatefulWidget {
  @override
  _FoodSocialMediaAppState createState() => _FoodSocialMediaAppState();
}

class _FoodSocialMediaAppState extends State<FoodSocialMediaApp> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomePage(),
    ExplorePage(),
    PhotoSharingPage(),
  ];

  @override
  Widget build(BuildContext context) {

    Color appBarColour = const Color.fromRGBO(219, 250, 165, 100);
    Color appBarTextColour = const Color(0xFF485868);

    return MaterialApp(
      title: 'wrapped',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'wrapped',
            style: TextStyle(
              color: appBarTextColour,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              ),
            ),
          backgroundColor: appBarColour,
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_off_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Share',
            ),
          ],
        ),
      ),
    );
  }
}
