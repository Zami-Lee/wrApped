import 'package:flutter/material.dart';

import 'explore_page/explore_page.dart';
import 'home_page/home_page.dart';
import 'photo_page/photo_page.dart';

void main() => runApp(FoodSocialMediaApp());

Color appBarColour = const Color(0xFFF88DAD);
Color appBarTextColour = const Color(0xFF6F5E76);

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

    return MaterialApp(
      title: 'wrApped',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'wrApped',
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
